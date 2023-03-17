//
//  TabBarView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 11.03.2023.
//

import SwiftUI

struct CustomTabView: View {
    // MARK: - Constants
    enum Constants {
        static let main = Image("main")
        static let feed = Image("feed")
        static let friends = Image("friends")
    }
    
    @State private var selection = 2
    
    // MARK: - Views
    var body: some View {
        TabView (selection: $selection) {
            FeedView()
                .tabItem {
                    Constants.feed.renderingMode(.template)
                    Text("Feed")
                }.tag(1)
            
            MainPageView()
                .tabItem {
                    Constants.main.renderingMode(.template)
                    Text("Main")
                }.tag(2)
            
            FriendsView()
                .tabItem {
                    Constants.friends.renderingMode(.template)
                    Text("Friends")
                }
                .tag(3)
                .badge(3)
        }
        .onAppear() {
            let appearance = UITabBarAppearance()
            appearance.backgroundColor = UIColor(.black)
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .accentColor(.dl.mainCol())
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView()
    }
}
