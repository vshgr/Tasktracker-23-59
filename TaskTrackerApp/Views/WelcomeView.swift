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
    @State var navigate: Bool = false
    
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
                        navigate = true
                    }
                    .padding(.horizontal, Grid.stripe * 2)
                    .padding(.bottom, Grid.stripe * 2)
                }
            }
            .navigationBarHidden(true)
            .navigationDestination(
                isPresented: $navigate) {
                    EmailView()
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
