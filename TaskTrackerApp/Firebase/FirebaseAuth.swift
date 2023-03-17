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
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    @Published var errorMessage: String?
    
    var signedIn: Bool {
        return auth.currentUser != nil
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
    
    func insertNewUser(email: String, password: String) {
//        var ref: DocumentReference? = nil
//        ref = db.collection("users").addDocument(data: [
//            "email": email,
//            "name": "",
//            "password": password,
//            "username": ""
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
        
        db.collection("users").document(email).setData([
            "email": email,
            "name": "",
            "password": password,
            "username": ""
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func getCurrentUser() -> FirebaseAuth.User? {
        if (auth.currentUser != nil) {
            return auth.currentUser
        }
        
        return nil
    }
    
    func insertUserInfo(email: String, username: String, name: String) {
        let docRef = db.collection("users").document(auth.currentUser?.email ?? "")
        docRef.updateData([
            "username": username,
            "name": name
        ])
    }
    
    func getUserName() -> String {
        let email: String = auth.currentUser?.email ?? ""
        var username: String = ""
        let docRef = db.collection("users").document(email)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                username = data!["username"]! as? String ?? ""
                print(username)
            } else {
                print("Document does not exist")
            }
        }
        
        return username
    }
    
    func getName() -> String {
        let email: String = auth.currentUser?.email ?? "qwerty@gmail.com"
        var name: String = ""
        let docRef = db.collection("users").document(email)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                name = data!["name"]! as? String ?? ""
                print(name)
            } else {
                print("Document does not exist")
            }
        }
        
        return name
    }
}
