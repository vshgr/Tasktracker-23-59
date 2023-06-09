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
                        NavigationLink(destination: TaskPageView(task: task, userOwner: taskOwner)) {
//                            TaskView(isDone: task.done ,taskOwner: taskOwner, taskID: task.id ?? "", selfTask: isSelf)
                            TaskView(isDone: task.done ,taskOwner: taskOwner, task: task, selfTask: isSelf)
                        }
                    }
                } else {
                    Text("no tasks :(")
                        .foregroundColor(.dl.hintCol())
                }
            }
        }
        .padding(.top, CommonConstants.contentStackSpacing)
    }
}
