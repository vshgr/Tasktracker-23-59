//
//  FeedView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 11.03.2023.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject private var viewModel = AppViewModel()
    @State private var text: String = ""
    @State private var tasks: [Task] = [Task]()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("Feed")
                        .font(.dl.ralewayBold(20))
                        .padding(.top, CommonConstants.topSpace)
                    SearchView(text: $text)
                    ScrollView (showsIndicators: false) {
                        VStack(alignment: .leading, spacing: CommonConstants.contentStackSpacing) {
                            if viewModel.fetchFeed().count > 0 {
                                ForEach(viewModel.fetchFeed()) { task in
                                    NavigationLink(destination: TaskPageView(task: task, userOwner: viewModel.getUserByTaskId(taskId: task.id ?? ""))) {
                                        TaskView(isDone: task.done ,taskOwner: viewModel.getUserByTaskId(taskId: task.id ?? ""), task: task, selfTask: false)
                                    }
                                }
                            } else {
                                Text("no tasks :(")
                                    .foregroundColor(.dl.hintCol())
                            }
                        }
                    }
                    .onAppear() {
                        viewModel.fetchSubscriptions()
                    }
                    .padding(.top, CommonConstants.contentStackSpacing)
                }
                .padding(.horizontal, Grid.stripe)
            }
        }
    }
}

struct FeedV: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

