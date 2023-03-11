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
    
    @State private var isDone = false
    private let task: Task = Task()
    private let selfTask: Bool
    private let width: CGFloat = 13
    private var dateView: BubbleView
    private var taskClicked: (() -> Void)?
    
    // MARK: - Init
    
    init(isSelfTask: Bool = true) {
        selfTask = isSelfTask
        dateView = BubbleView(bubbleText: task.deadline, isInteractable: false)
    }
    
    // MARK: - Views
    
    var body: some View {
        HStack (spacing: CommonConstants.smallContentSpacing) {
            VStack(alignment: .leading, spacing: CommonConstants.contentStackSpacing) {
                if selfTask == false {
                    FriendHeaderView()
                }
                if selfTask == true {
                    Text(task.permission.rawValue)
                        .font(.dl.ralewayMedium(12))
                        .foregroundColor(Color.dl.hintCol())
                }
                Text(task.name)
                    .font(.dl.ralewayBold(14))
                    .foregroundColor(Color.black)
                    .lineLimit(3)
                HStack(spacing: CommonConstants.horizontalStackSpacing) {
                    dateView
                    Text(task.groups.joined(separator: Constants.separator))
                        .font(CommonConstants.mainLabelFont)
                        .foregroundColor(Color.dl.hintCol())
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.all, CommonConstants.smallContentSpacing)
            .padding(.trailing, 10)
//            .frame(maxWidth: .infinity)
            .background(Constants.taskColor)
            .onTapGesture {
                taskClicked?()
            }
            .cornerRadius(10)
            VStack(spacing: CommonConstants.contentStackSpacing) {
                Button(action: setDone) {
                    Constants.done
                        .resizable()
                        .frame(width: 30, height: 30)
                        .opacity(isDone ? 0.3 : 1)
                }
                Button(action: {}) {
                    Constants.add
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.dl.hintCol())
                }
            }
            .padding(.leading, -30)
        }
    }
    
    // MARK: - Actions
    
    private func setDone(){
        withAnimation(.easeInOut(duration: 0.5)) {
            isDone.toggle()
        }
    }
    
    // MARK: - Getters
    
    public func getTitle() -> String {
        return task.name
    }
    
    public func getDesc() -> String {
        return task.description
    }
    
    public func getDate() -> String {
        return dateView.getText()
    }
}

struct T: PreviewProvider {
    static var previews: some View {
        TaskView(isSelfTask: false)
    }
}
