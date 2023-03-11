//
//  User.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

struct User {
    var name: String
    var username: String
    var email: String
    var profilePicUrl: String
}

extension User {
    init() {
        name = "Yana Barbashina"
        username = "yana_wishnya"
        email = "yana_wishnya@hse.ru"
        profilePicUrl = "dog"
    }
}
