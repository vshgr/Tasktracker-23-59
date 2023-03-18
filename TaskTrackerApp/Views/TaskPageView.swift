//
//  TaskPageView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 17.03.2023.
//

import SwiftUI

struct TaskPageView: View {
    
    // MARK: - Constants
    private enum Constants {
        static let scrollHeight: CGFloat = 40
        static let linesSpacing: CGFloat = 6
    }
    
    // MARK: - Fields
    private let task = Task()
    
    // MARK: - UI Components
    private let friend = TaskOwnerView()
//    private let groupsScroll = BubblesScrollView(type: .filled)
    
    // MARK: - View Lifecycle
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: CommonConstants.contentStackSpacing) {
                HStack {
                    friend
                    Spacer()
                    Text(task.deadlineDate.formatted())
                        .font(.system(size: 12))
                }
                //            groupsScroll
                //                .frame(height: Constants.scrollHeight)
                Text(task.name)
                    .font(.dl.ralewayBold())
                ScrollView {
                    Text(task.description)
                        .lineSpacing(Constants.linesSpacing)
                        .font(.dl.ralewayMedium())
                }
            }
            .padding(.all, Grid.stripe)
            .navigationBarTitle("Task")
            .navigationBarItems(trailing: barButtonView)
        }
    }
    
    private var barButtonView: some View {
        HStack (spacing: CommonConstants.smallContentSpacing) {
            Image(systemName: "trash.fill")
            Image(systemName: "bell.fill")
        }
    }
}

struct TP: PreviewProvider {
    static var previews: some View {
        TaskPageView()
    }
}
