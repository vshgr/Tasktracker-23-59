//
//  User.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

struct User: Comparable {
    var name: String
    var username: String
    var email: String
    var friends: [User]
    var profilePicUrl: String
    
    static func ==(lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name &&
        lhs.username == rhs.username &&
        lhs.email == rhs.email
    }
    
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.name < rhs.name
    }
}

extension User {
    init() {
        name = "Yana Barbashina"
        username = "yana_wishnya"
        email = "yana_wishnya@hse.ru"
        friends = [User]()
        profilePicUrl = "dog"
    }
}
