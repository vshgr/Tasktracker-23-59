//
//  EmailView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State var navigate: Bool = false
    
    @EnvironmentObject var viewModel: AppViewModel
    
    // METHOD FOR STORING USER DATA
    func logIn(email: String, password: String) {
        viewModel.signIn(email: email, password: password) { result in
            switch result {
            case (.success(_)) :
                navigate = true
            case(.failure(let error)):
                viewModel.errorMessage = error.errorMessage
                errorMessage = viewModel.errorMessage ?? ""
                showAlert = true
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 20) {
            Spacer()
            InputView(title: "Email", text: $email, hint: "enter email...", keyboardType: .emailAddress, inputType: .email)
                .padding(.horizontal, Grid.stripe)
            InputView(title: "Password", text: $password, hint: "enter password...", keyboardType: .default, inputType: .password)
                .padding(.horizontal, Grid.stripe)
            Spacer()
            ButtonView(title: "Log In") {
                logIn(email: email, password: password)
            }
            .navigationDestination(
                isPresented: $navigate) {
                    CustomTabView()
                }
                .padding(.horizontal, Grid.stripe * 2)
                .padding(.bottom, Grid.stripe * 2)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    var body: some View {
        if viewModel.signedIn {
            CustomTabView()
        } else {
            content
        }
    }
}

//struct EmailView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
