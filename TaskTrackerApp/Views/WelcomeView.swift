//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

struct WelcomeView: View {
    // MARK: - Fields
    let onboardingIconView = Image("onboarding_logo")
    @State var navigateToLogin: Bool = false
    @State var navigateToRegister: Bool = false

    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                Color.dl.mainCol()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    onboardingIconView
                        .padding()
                    
                    Spacer()
                    ButtonView(title: "Sign in") {
                        navigateToLogin = true
                    }
                    .padding(.horizontal, Grid.stripe * 2)
                    Button(action: {
                       navigateToRegister = true
                    }, label: {
                        Text("Sign up")
                            .font(.dl.mainFont())
                            .foregroundColor(.black)
                            .frame(height: 70)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: 35)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                    })
                    .padding(.horizontal, Grid.stripe * 2)
                    .padding(.bottom, Grid.stripe * 2)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(
                isPresented: $navigateToLogin) {
                    LoginView()
                    Text("")
                        .hidden()
                }
                .navigationDestination(
                    isPresented: $navigateToRegister) {
                        RegisterView()
                        Text("")
                            .hidden()
                    }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
