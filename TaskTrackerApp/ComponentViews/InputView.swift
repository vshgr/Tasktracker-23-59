//
//  ImputView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

enum InputType {
    case email
    case normal
    case username
    case date
    case password
}

struct InputView: View {
    // MARK: - Constants
    enum Constants {
        static let underlineSpacind: CGFloat = 8
        static let errorSpacing: CGFloat = 11
    }
    
    // MARK: - Fields
    let title: String
    @Binding var text: String
    let hint: String
    let keyboardType: UIKeyboardType
    let inputType: InputType
    
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.errorSpacing) {
            Text(title)
                .foregroundColor(.black)
                .font(.system(size: 17))
            VStack(alignment: .leading) {
                if inputType == .normal || inputType == .username {
                    TextField(hint, text: $text)
                        .foregroundColor(.black)
                        .keyboardType(keyboardType)
                } else if inputType == .email {
                    TextField(hint, text: $text)
                        .foregroundColor(.black)
                        .keyboardType(keyboardType)
                        .textContentType(.emailAddress)
                } else if inputType == .date {
                    DatePicker(hint, selection: .constant(Date()), displayedComponents: [.hourAndMinute])
                        .datePickerStyle(WheelDatePickerStyle())
                } else if inputType == .password {
                    SecureField(hint, text: $text)
                        .foregroundColor(.black)
                        .keyboardType(keyboardType)
                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
        }
        .padding(.vertical, Constants.underlineSpacind)
    }
    
}

