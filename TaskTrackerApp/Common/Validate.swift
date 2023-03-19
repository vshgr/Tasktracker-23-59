//
//  Validate.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import Foundation

struct Validate {
    static func checkInputCorrect(type: InputType, value: String) -> Bool {
        let regEx: String
        let pred: NSPredicate
        switch type {
        case InputType.email:
            regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            pred = NSPredicate(format:"SELF MATCHES %@", regEx)
            return pred.evaluate(with: value)
        case InputType.username:
            regEx = "\\w{5,18}"
            pred = NSPredicate(format:"SELF MATCHES %@", regEx)
            return pred.evaluate(with: value)
        default:
            return !value.trimmingCharacters(in: .whitespaces).isEmpty
        }
    }    
}
