//
//  EmailView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

struct EmailView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State var navigate: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                InputView(title: "Email", text: $email, hint: "enter email...", keyboardType: .emailAddress, inputType: .email)
                    .padding(.horizontal, Grid.stripe)
                InputView(title: "Password", text: $password, hint: "enter password...", keyboardType: .default, inputType: .password)
                    .padding(.horizontal, Grid.stripe)
                Spacer()
                ButtonView(title: "Log In") {
                    var flag = false
                    
                    if !Validate.checkInputCorrect(type: .normal, value: password) {
                        flag = true
                        errorMessage = "Fill password"
                    }
                    if !Validate.checkInputCorrect(type: .email, value: email) {
                        flag = true
                        errorMessage = "Invalid email format"
                    }
                    
                    navigate = !flag
                    showAlert = flag
                    
                }
                .padding(.horizontal, Grid.stripe * 2)
                .padding(.bottom, Grid.stripe * 2)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarHidden(true)
            .navigationDestination(
                isPresented: $navigate) {
                    CreateAccountView()
                    Text("")
                        .hidden()
                }
            
        }
    }
}

struct EmailView_Previews: PreviewProvider {
    static var previews: some View {
        EmailView()
    }
}

