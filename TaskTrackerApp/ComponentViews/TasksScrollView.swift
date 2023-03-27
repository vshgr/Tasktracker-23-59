//
//  TasksScrollView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 27.03.2023.
//

import SwiftUI

struct TasksScrollView: View {
    var tasks: [Task]
    var taskOwner: User
    var isSelf: Bool

    // MARK: - Body
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack(alignment: .leading, spacing: CommonConstants.contentStackSpacing) {
                if tasks.count > 0 {
                    ForEach(tasks) { task in
                        NavigationLink(destination: TaskPageView(taskId: task.id ?? "", userOwner: taskOwner)) {
                            TaskView(taskOwner: taskOwner, taskID: task.id ?? "", selfTask: isSelf)
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
