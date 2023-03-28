//
//  FirestoreFriends.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 25.03.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


extension AppViewModel {
    func getFriendByEmail(email: String) -> User {
        var ret = User()
        for user in users {
            if user.email == email {
                ret = user
            }
        }
        return ret
    }
    
    func searchUserByUsername(username: String) -> User {
        var ret = User()
        for user in users {
            if user.username.lowercased().starts(with: username.lowercased()) {
                ret = user
            }
        }
        return ret
    }
    
    func addSubscription(email: String) {
        let userRef = db.collection("users").document(auth.currentUser?.email ?? "")

        userRef.updateData([
            "subscriptions": FieldValue.arrayUnion([email])
        ])
    }
    
    func removeSubscription(email: String) {
        let userRef = db.collection("users").document(auth.currentUser?.email ?? "")
        
        userRef.updateData([
            "subscriptions": FieldValue.arrayRemove([email])
        ])
    }
}
