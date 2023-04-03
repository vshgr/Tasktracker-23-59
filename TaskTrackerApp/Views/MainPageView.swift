//
//  MainPageView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

struct MainPageView: View {
    // MARK: - Constants
    enum Constants {
        static let tapsNum: Int = 1
        static let offset: Double = 0
        static let picWH: Double = 75
        static let filter: Image = Image("filter")
        static let title: String = "tasks"
    }
    
    // MARK: - Fields
    @State private var isTaskPagePresented: Bool = false
    @State private var isFilterPagePresented: Bool = false
    @State private var isProfilePresented: Bool = false
    @State private var isNewTaskPagePresented: Bool = false
    @ObservedObject var viewModel = AppViewModel()
    @State private var isTasksPresented: Bool = false
    
    // MARK: - Setups
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack (alignment: .leading) {
                    ProfileInfoView(user: viewModel.getUser() ?? User())
                        .padding(.top, CommonConstants.topSpace)
                        .onTapGesture {
                            isProfilePresented = true
                        }
                    
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
                    TasksScrollView(tasks: viewModel.tasks, taskOwner: viewModel.getUser() ?? User(), isSelf: true)
                }
                .padding(.horizontal, Grid.stripe)

                VStack (alignment: .trailing) {
                    Spacer()
                    HStack {
                        Spacer()
                        AddTaskGroupButtonsView(isAddTaskClicked: $isNewTaskPagePresented)
                            .padding(.bottom, Grid.stripe)
                            .padding(.trailing, Grid.stripe)
                    }
                    
                }
            }
        }
        .navigationDestination(
            isPresented: $isProfilePresented) {
                MyProfileView()
            }
            .navigationDestination(
                isPresented: $isNewTaskPagePresented) {
                    NewTaskPageView()
                }
                .navigationBarHidden(true)
    }
}


struct MainTasksPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}

