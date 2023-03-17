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
        let db = Firestore.firestore()
        
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
}
