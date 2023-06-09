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
        static let trash: Image = Image(systemName: "trash.fill")
    }
    
    // MARK: - Fields
//    var taskId: String
    var task: Task
    var userOwner: User
    @ObservedObject private var viewModel = AppViewModel()
    @State private var showAlert: Bool = false
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    //    private let groupsScroll = BubblesScrollView(type: .filled)
    
    // MARK: - View Lifecycle
    var body: some View {
        VStack(alignment: .leading, spacing: CommonConstants.contentStackSpacing) {
            HStack {
                TaskOwnerView(user: userOwner)
                Spacer()
                if task.deadlineDate != Date(timeIntervalSince1970: 0) {
                    Text(task.deadlineDate.formatted())
                        .font(.system(size: 12))
                }
            }
            // TODO: вернуть, когда появятся группы
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
        .onAppear() {
            viewModel.fetchFriendsTasks(email: userOwner.email)
        }
        .padding(.all, Grid.stripe)
        .navigationBarTitle("Task")
        .navigationBarItems(leading: CustomBackButton(), trailing: barButtonView)
        .navigationBarBackButtonHidden(true)
    }
    
    private var barButtonView: some View {
        HStack (spacing: CommonConstants.smallContentSpacing) {
            if userOwner == viewModel.getUser() {
                Constants.trash
                    .onTapGesture {
                        showAlert = true
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Are you sure you want to delete task?"),
                            message: Text("There is no undo"),
                            primaryButton: .destructive(Text("Delete")) {
                                viewModel.deleteTask(id: task.id ?? "")
                                presentationMode.wrappedValue.dismiss()
                            },
                            secondaryButton: .cancel()
                        )
                    }
            }
            // TODO: вернуть, когда появятся уведомления
//            Image(systemName: "bell.fill")
        }
    }
}

//struct TP: PreviewProvider {
//    static var previews: some View {
//        TaskPageView()
//    }
//}
