//
//  RegisterView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 16.03.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @State var navigate: Bool = false
    @EnvironmentObject var viewModel: AppViewModel
    
    // METHOD FOR STORING USER DATA
    func signUp(email: String, password: String) {
        viewModel.signUp(email: email, password: password) { result in
            switch result {
            case (.success(_)) :
                navigate = true
                viewModel.insertNewUser(email: email)
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
            ButtonView(title: "Sign up") {
                signUp(email: email, password: password)
            }
            .navigationDestination(
                isPresented: $navigate) {
                    CreateAccountView()
                }
                .padding(.horizontal, Grid.stripe * 2)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    var body: some View {
        content
    }
}

//struct RegView: PreviewProvider {
//    static var previews: some View {
//        RegisterView()
//    }
//}
