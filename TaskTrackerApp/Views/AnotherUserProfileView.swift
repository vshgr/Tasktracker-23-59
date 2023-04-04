//
//  AnotherUserProfileView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 25.03.2023.
//

import SwiftUI
import UIKit

struct AnotherUserProfileView: View {
    // MARK: - Constants
    enum Constants {
        static let tapsNum: Int = 1
        static let offset: Double = 0
        static let picWH: Double = 75
        static let filter: Image = Image("filter")
        static let title: String = "tasks"
    }
    
    // MARK: - Fields
    var user: User
    @State private var isTaskPagePresented: Bool = false
    @State private var isFilterPagePresented: Bool = false
    @ObservedObject var viewModel = AppViewModel()
    
    init(user: User) {
        self.user = user
        viewModel.fetchFriendsTasks(email: user.email)
    }
    
    // MARK: - Setups
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading) {
                ProfileInfoView(user: user)
                    .padding(.top, CommonConstants.topSpace)
                
                if viewModel.isUserInSubscriptions(email: user.email) {
                    ButtonView(title: "unsubscribe", height: 50) {
                        viewModel.removeSubscription(email: user.email)
                    }
                        .padding(.top, CommonConstants.smallContentSpacing)
                } else {
                    ButtonView(title: "subscribe", height: 50) {
                        viewModel.addSubscription(email: user.email)
                    }
                        .padding(.top, CommonConstants.smallContentSpacing)
                }
                
                HStack(spacing: CommonConstants.smallContentSpacing) {
                    Text(Constants.title)
                        .font(.dl.ralewayBold(20))
                        .foregroundColor(.black)
//                    
//                    Button(action: {
//                        isFilterPagePresented = true
//                    }, label: {
//                        Constants.filter
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                    })
                }
                .padding(.top, CommonConstants.smallContentSpacing)
                TasksScrollView(tasks: viewModel.anotherTasks, taskOwner: user, isSelf: false)
            }
            .padding(.horizontal, Grid.stripe)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
    }
}

struct AnotherUserProfileViewpr: PreviewProvider {
    static var previews: some View {
        AnotherUserProfileView(user: User())
    }
}


