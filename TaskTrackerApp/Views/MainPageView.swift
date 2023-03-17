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
    @State private var isAddTaskPopupPresented = false
    @State private var isTaskPagePresented = false
    @State private var isFilterPagePresented = false
    @State private var isProfilePresented = false
    private var addGroup = AddTaskGroupButtonsView()
    
    func taskClicked () {
        
    }
    // MARK: - Setups
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading) {
                    ProfileInfoView()
                        .padding(.top, CommonConstants.topSpace)
                        .padding(.horizontal, Grid.stripe)
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
                    .padding(.horizontal, Grid.stripe)
                    
                    ScrollView (showsIndicators: false){
                        VStack(spacing: CommonConstants.contentStackSpacing) {
                            ForEach(0..<10) { index in
                                TaskView(isSelfTask: Bool.random())
                                    .onTapGesture {
                                        isTaskPagePresented = true
                                    }
                            }
                        }
                    }
                    .padding(.top, CommonConstants.contentStackSpacing)
                    .padding(.horizontal, Grid.stripe)
                }
                VStack (alignment: .trailing){
                    Spacer()
                    HStack {
                        Spacer()
                        addGroup
                        .padding(.bottom, Grid.stripe)
                        .padding(.trailing, Grid.stripe)
                        .onTapGesture {
                            isAddTaskPopupPresented = true
                            print(isAddTaskPopupPresented)
                        }
                    }
                    
                }
                if isAddTaskPopupPresented {
                    Rectangle()
                        .fill(.black)
                        .frame(width: 100,height: 100)
                }
            }
            .navigationDestination(
                isPresented: $isProfilePresented) {
                    MyProfileView()
                    Text("")
                        .hidden()
                }
                .navigationDestination(
                    isPresented: $isTaskPagePresented) {
                        TaskPageView()
                        Text("")
                            .hidden()
                    }
                    .navigationBarHidden(true)
        }
    }
}

struct MainTasksPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}

