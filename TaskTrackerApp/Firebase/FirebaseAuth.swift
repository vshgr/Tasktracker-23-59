//
//  FirebaseAuth.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 17.03.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

enum FBError: Error, Identifiable {
    case error(String)
    
    var id: UUID {
        UUID()
    }
    
    var errorMessage: String {
        switch self {
        case .error(let message):
            return message
        }
    }
}

class AppViewModel: ObservableObject {
    // MARK: - Fields
    @Published var users = [User]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    @Published var errorMessage: String?
    
    // MARK: - Getter
    var signedIn: Bool {
        return auth.currentUser != nil
    }
    
    // MARK: - Actions
    func fetchData() {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let users = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.users = users.map { queryDocumentSnapshot -> User in
                let data = queryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let username = data["username"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let tasks = data["tasks"] as? [Task] ?? []
                return User(name: name, username: username, email: email, profilePicUrl: "none", tasks: tasks)
            }
        }
    }
    
    func getUser() -> User? {
        for user in users {
            if user.email == auth.currentUser?.email {
                return user
            }
        }
        return nil
    }
    
    
    func signIn (email: String, password: String, complition: @escaping (Result<Bool, FBError>) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error {
                DispatchQueue.main.async {
                    complition(.failure(.error(error.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async{
                    complition(.success(true))
                }
            }
        }
    }
    
    func signUp (email: String, password: String, complition: @escaping (Result<Bool, FBError>) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error {
                DispatchQueue.main.async {
                    complition(.failure(.error(error.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async{
                    complition(.success(true))
                }
            }
        }
    }
    
    func insertNewUser(email: String) {
        db.collection("users").document(email).setData([
            "email": email,
            "name": "",
            "username": "",
            "tasks": []
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func insertUserInfo(email: String, username: String, name: String) {
        let docRef = db.collection("users").document(auth.currentUser?.email ?? "")
        docRef.updateData([
            "username": username,
            "name": name
        ])
    }
    
    func insertTask(email: String, task: Task) {
        let docRef = db.collection("users").document(auth.currentUser?.email ?? "")
        var newTasks = getUserTasks()
        newTasks.append(task)
        docRef.updateData([
            "tasks": newTasks
        ])
    }
    
    func getUserTasks() -> [Task] {
        for user in users {
            if user.email == auth.currentUser?.email {
                return user.tasks
            }
        }
        return []
    }
}
