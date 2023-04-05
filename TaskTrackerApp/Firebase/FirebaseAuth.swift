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
    @Published var tasks = [Task]()
    @Published var anotherTasks = [Task]()
    @Published var subscriptions = [User]()
    @Published var isUserLoggedOut = false
    @Published var subTasks = [Task]()
    let auth = Auth.auth()
    let db = Firestore.firestore()
    @Published var errorMessage: String?
    
    init() {
        DispatchQueue.main.async {
            self.isUserLoggedOut = self.auth.currentUser?.uid == nil
        }
        fetchData()
    }
    
    func handleSignOut() {
        isUserLoggedOut.toggle()
        try? auth.signOut()
    }
    
    var signedIn: Bool {
        return auth.currentUser != nil
    }
    
    // MARK: - Actions
    func fetchData() {
        if (signedIn) {
            db.collection("users").addSnapshotListener { [self] (querySnapshot, error) in
                guard let users = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.users = users.map { queryDocumentSnapshot -> User in
                    let data = queryDocumentSnapshot.data()
                    let name = data["name"] as? String ?? ""
                    let username = data["username"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let pic = data["pic"] as? String ?? "none"
                    let subscriptionsEmails = data["subscriptions"] as? [String] ?? [String]()
                
                    return User(name: name, username: username, email: email, subscriptions: subscriptionsEmails, profilePicUrl: pic)
                }
            }
            getTasks()
            fetchSubscriptions()
            for elem in subscriptions {
                fetchFriendsTasks(email: elem.email)
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
    
    func getUserByEmail(email: String) -> User? {
        for user in users {
            if user.email == email {
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
            "pic": ""
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func removeUser(email: String) {
        db.collection("users").document(email).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func insertUserInfo(email: String, username: String, name: String, pic: String, complition: @escaping (Result<Bool, FBError>) -> Void) {
        fetchData()
        var flag = false
        for usr in users {
            if usr.username == username {
                flag = true
            }
        }
        
        if flag {
            complition(.failure(.error("User with such username already exists")))
        } else {
            let docRef = db.collection("users").document(auth.currentUser?.email ?? "")
            docRef.updateData([
                "username": username,
                "name": name,
                "pic": pic
            ])
            complition(.success(true))
        }
    } 
}
