//
//  CreateAccountView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct CreateAccountView: View {
    // MARK: - Fields
    @State private var nameField = ""
    @State private var usernameField = ""
    @State private var emailField = ""
    @State var navigate: Bool = false
    @State var showAlert: Bool = false
    @State var errorMessage: String = ""
    
    @ObservedObject var viewModel = AppViewModel()
    
    // MARK: - Setups
    var body: some View {
        NavigationStack{
            VStack(spacing: CommonConstants.contentStackSpacing) {
                ProfileView()
                    .padding(.top, CommonConstants.topSpace)
                
                VStack(spacing: CommonConstants.contentStackSpacing) {
                    InputView(title: "Name", text: $nameField, hint: "enter name...", keyboardType: .numberPad, inputType: .normal)
                    InputView(title: "Username", text: $usernameField, hint: "enter username...", keyboardType: .numberPad, inputType: .username)
                    InputView(title: "Email", text: $emailField, hint: "\(viewModel.getUser()?.email ?? "test@gmail.com")", keyboardType: .numberPad, inputType: .normal).disabled(true)
                }
                .padding(.horizontal, Grid.stripe)
                .onAppear() {
                    viewModel.fetchData()
                }
                
                Spacer()
                ButtonView(title: "Create account") {
                    createButtonPressed()
                    viewModel.insertUserInfo(email: viewModel.getUser()?.email ?? "test@gmail.com", username: usernameField, name: nameField)
                }
                .padding(.bottom, Grid.stripe * 2)
                .padding(.horizontal, Grid.stripe * 2)
                
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Create account")
            .navigationDestination(
                isPresented: $navigate) {
                    MainPageView()
                    Text("")
                        .hidden()
                }
        }
    }
    
    // MARK: - Actions
    private func createButtonPressed() {
        var flag = true
        
        if (!Validate.checkInputCorrect(type: .username, value: usernameField)) {
            flag = false
            errorMessage = "Invalid username"
            showAlert = true
        }
        
        if (!Validate.checkInputCorrect(type: .normal, value: nameField)) {
            flag = false
            errorMessage = "Invalid name"
            showAlert = true
        }
        
        if (flag) {
            navigate = true
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}

