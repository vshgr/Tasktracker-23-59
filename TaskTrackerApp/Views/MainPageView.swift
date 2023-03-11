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

    // MARK: - Setups
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading){
                    ProfileInfoView()
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
                    
                    ScrollView {
                        VStack(spacing: CommonConstants.contentStackSpacing) {
                            ForEach(0..<10) { index in
                                Button(action: {
                                    isTaskPagePresented = true
                                }, label: {
                                    TaskView(isSelfTask: Bool.random())
                                })
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    .padding(.top, CommonConstants.contentStackSpacing)
                    .padding(.horizontal, Grid.stripe)                    
                    //                Button(action: {
                    //                    isAddTaskPopupPresented = true
                    //                }, label: {
                    //                    AddTaskGroupButtonsView()
                    //                })
                    //                .padding(Grid.stripe)
                }
            }
            //        .fullScreenCover(isPresented: $isAddTaskPopupPresented, content: {
            //            NewTaskFirstPage()
            //        })
            //        .fullScreenCover(isPresented: $isTaskPagePresented, content: {
            //            TaskPage()
            //        })
            //        .fullScreenCover(isPresented: $isFilterPagePresented, content: {
            //            FilterPage()
            //        })
        }
        .navigationBarHidden(true)
    }
}

struct MainTasksPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}

