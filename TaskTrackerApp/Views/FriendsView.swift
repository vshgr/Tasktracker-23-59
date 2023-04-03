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
                    Text("Subscriptions")
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
                    
                    if !viewModel.subscriptions.isEmpty {
                        Text("your subscriptions")
                            .padding(.top, 20)
                            .font(.dl.ralewayBold(15))
                        ScrollView {
                            ForEach(viewModel.subscriptions.indices, id: \.self) { user in
                                NavigationLink(destination: AnotherUserProfileView(user: viewModel.subscriptions[user])) {
                                    TaskOwnerView(user: viewModel.subscriptions[user])
                                        .padding(.top, CommonConstants.smallContentSpacing)
                                }
                            }
                        }
                    }
                    
                    if !searchedUsers.isEmpty {
                        Text ("search")
                            .padding(.top, 20)
                            .font(.dl.ralewayBold(15))
                        ScrollView {
                            ForEach(searchedUsers.indices, id: \.self) { user in
                                NavigationLink(destination: AnotherUserProfileView(user: searchedUsers[user])) {
                                    TaskOwnerView(user: searchedUsers[user])
                                        .padding(.top, CommonConstants.smallContentSpacing)
                                }
                            }
                        }
                    } else {
                        Spacer()
                    }
                }
                .padding(.horizontal, Grid.stripe)
            }
            .navigationBarBackButtonHidden(true)
            .onAppear() {
                viewModel.fetchData()
                viewModel.fetchSubscriptions()
            }
        }
    }
}

struct FV: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
