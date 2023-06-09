//
//  TaskView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

struct TaskView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let done: Image = Image("done")
        static let add: Image = Image("addToGroup")
        static let taskColor: Color = Color(rgb: 0xF8F8F8)
        static let separator: String = ", "
    }
    
    // MARK: - Properties
    
    @State private var added = false
    @State var isDone: Bool
    var taskOwner: User
//    var taskID: String
    var task: Task
    var selfTask: Bool
    @ObservedObject private var viewModel = AppViewModel()
    private let width: CGFloat = 13
//    @State private var task: Task = Task()
    @State private var boarderColor: Color = Color.black
    
    // MARK: - Views
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: CommonConstants.contentStackSpacing) {
                // TODO: вернуть, когда появятся пермишены
                //                    Text(task.permission.rawValue)
                //                        .font(.dl.ralewayMedium(12))
                //                        .foregroundColor(Color.dl.hintCol())
                Text(task.name)
                    .font(.dl.ralewayBold(14))
                    .foregroundColor(Color.black)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: CommonConstants.horizontalStackSpacing) {
                    if task.deadlineDate !=  Date.init(timeIntervalSince1970: 0) {
                        BubbleView(bubbleText: task.deadlineDate.formatted(), isInteractable: false)
                    }
                    // TODO: вернуть, когда появятся группы
                    //                    Text(task.groups.joined(separator: Constants.separator))
                    //                        .font(CommonConstants.mainLabelFont)
                    //                        .foregroundColor(Color.dl.hintCol())
                    //                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.all, CommonConstants.smallContentSpacing)
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Constants.taskColor)
            .cornerRadius(10)
            VStack(spacing: CommonConstants.contentStackSpacing) {
                if selfTask {
                    Button(action: setDone) {
                        Constants.done
                            .resizable()
                            .frame(width: 30, height: 30)
                            .opacity(isDone ? 0.3 : 1)
                    }
                } else {
                    if !added && !viewModel.isInSelfTasks(task: task) {
                        Button(action: addToSelfTasks) {
                            Image("addToGroup")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .opacity(added ? 0.3 : 1)
                        }
                    }
                }
                // TODO: вернуть, когда появятся группы
                //                Button(action: {}) {
                //                    Constants.add
                //                        .resizable()
                //                        .frame(width: 30, height: 30)
                //                        .foregroundColor(Color.dl.hintCol())
                //                }
            }
            .padding(.leading, -25)
        }
        .onAppear() {
            viewModel.fetchFriendsTasks(email: taskOwner.email)
        }
    }
    
    // MARK: - Actions
    
    private func setDone() {
        withAnimation(.easeInOut(duration: 0.5)) {
            self.isDone.toggle()
            viewModel.setTaskDone(taskID: task.id ?? "", isDone: isDone)
        }
    }
    
    private func addToSelfTasks() {
        added = true
//        let task = viewModel.getTaskByID(id: task.id)
        viewModel.insertTask(email: viewModel.getUser()?.email ?? "", task: task)
    }
}

//struct T: PreviewProvider {
//    static var previews: some View {
//        TaskView(isSelfTask: false, taskData: Task(name: "123", description: "123", deadlineDate: Date()))
//    }
//}
