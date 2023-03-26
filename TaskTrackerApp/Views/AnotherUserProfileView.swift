//
//  AnotherUserProfileView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 25.03.2023.
//

import SwiftUI

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
        self.viewModel.getTasksByEmail(email: user.email)
    }
    
    // MARK: - Setups
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading) {
                ProfileInfoView(user: user)
                    .padding(.top, CommonConstants.topSpace)
                    .padding(.horizontal, Grid.stripe)
                
                HStack(spacing: CommonConstants.smallContentSpacing) {
                    Text(Constants.title)
                        .font(.dl.ralewayBold(20))
                        .foregroundColor(.black)
                    
                    Button(action: {
                        isFilterPagePresented = true
                    }, label: {
                        Constants.filter
                            .resizable()
                            .frame(width: 20, height: 20)
                    })
                }
                .padding(.top, CommonConstants.smallContentSpacing)
                .padding(.horizontal, Grid.stripe)
                
                ScrollView (showsIndicators: false) {
                    VStack(alignment: .leading, spacing: CommonConstants.contentStackSpacing) {
                        if viewModel.anotherTasks.count > 0 {
                            ForEach(viewModel.anotherTasks) { task in
                                NavigationLink(destination: TaskPageView(taskId: task.id ?? "", userOwner: user)) {
                                    TaskView(taskID: task.id ?? "", selfTask: false)
                                }
                            }
                        } else {
                            Text("no tasks :(")
                                .foregroundColor(.dl.hintCol())
                        }
                    }
                }
                .padding(.top, CommonConstants.contentStackSpacing)
                .padding(.horizontal, Grid.stripe)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
//        .onAppear() {
//            self.viewModel.fetchUserTask(email: user.email)
//        }
    }
}

struct AnotherUserProfileViewpr: PreviewProvider {
    static var previews: some View {
        AnotherUserProfileView(user: User())
    }
}


