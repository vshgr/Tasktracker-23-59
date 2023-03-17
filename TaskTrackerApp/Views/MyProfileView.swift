//
//  ProfileView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 16.03.2023.
//

import SwiftUI

struct MyProfileView: View {
    private enum Constants {
        static let photo: Image = Image("dog")
        static let photoWidth: CGFloat = 146
    }
    
    @EnvironmentObject var viewModel: AppViewModel
    @State private var isSignedOut = false
    @State private var name = "Yana Barbashina"
    @State private var username = "@yana_wishnya"
    private let user = User()
    
    private var photoArea: some View {
        Image(user.profilePicUrl)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: Constants.photoWidth, height: Constants.photoWidth)
    }
    
    var body: some View {
        NavigationStack {
            photoArea
                .padding(.top, CommonConstants.topSpace)
            VStack(alignment: .leading, spacing: CommonConstants.contentStackSpacing) {
                Text(name)
                    .padding(.top, CommonConstants.contentStackSpacing)
                    .padding(.leading, Grid.stripe)
                    .font(.dl.mainFont())
                Text(username)
                    .padding(.leading, Grid.stripe)
                    .font(.dl.ralewayRegular())
                Spacer()
                ButtonView(title: "Log out") {
                    isSignedOut = true
                    do {
                        try viewModel.auth.signOut()
                    } catch let signOutError as NSError {
                        isSignedOut = false
                        print("Error signing out: %@", signOutError)
                    }                    
                }
                .padding(.bottom, Grid.stripe * 2)
                .padding(.horizontal, Grid.stripe * 2)
                
            }
        }
        .navigationDestination(isPresented: $isSignedOut) {
            WelcomeView()
        }
    }
}

struct MP: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
