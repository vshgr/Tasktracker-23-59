//
//  ProfileView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 16.03.2023.
//

import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isSignedOut = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: CommonConstants.contentStackSpacing) {
                ProfileView()
                    .padding(.top, CommonConstants.topSpace)
                
                
                Spacer()
                ButtonView(title: "Log out") {
                    isSignedOut = true
                    do {
                        try viewModel.auth.signOut()
                    } catch let signOutError as NSError {
                        isSignedOut = false
                        print("Error signing out: %@", signOutError)
                    }
                    print(viewModel.signedIn)
                    
                }
                .padding(.bottom, Grid.stripe * 2)
                .padding(.horizontal, Grid.stripe * 2)
                
            }
        }
        .navigationDestination(isPresented: $isSignedOut) {
            EmailView()
        }
    }
}

struct MP: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
