//
//  FriendsView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 11.03.2023.
//

import SwiftUI

struct FriendsView: View {
    let developmentComponent = DevelopmentComponent()
    @ObservedObject private var viewModel = AppViewModel()
    @State private var searchText: String = ""
    @State private var searchedUsers: [User] = [User]()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("Friends")
                        .font(.dl.ralewayBold(20))
                        .padding(.top, CommonConstants.topSpace)
                    SearchView(text: $searchText) {
                        searchedUsers.removeAll()
                    }
                        .padding(.top, CommonConstants.smallContentSpacing)
                        .onSubmit {
                            searchedUsers.removeAll()
                            let user = viewModel.searchUserByUsername(username: searchText.trimmingCharacters(in: .whitespaces))
                            print(user)
                            if user != User() {
                                searchedUsers.append(user)
                            }
                        }
                    ScrollView {
                        if (!searchedUsers.isEmpty) {
                            ForEach(searchedUsers.indices, id: \.self) { user in
                                NavigationLink(destination: AnotherUserProfileView(user: searchedUsers[user])) {
                                    TaskOwnerView(user: searchedUsers[user])
                                         .padding(.top, CommonConstants.smallContentSpacing)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, Grid.stripe)
                
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct FV: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
