//
//  NewTaskPage.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 17.03.2023.
//

import SwiftUI

struct NewTaskPageView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var deadlineDate: Date = Date()
    @ObservedObject var viewModel = AppViewModel()
    
    var body: some View {
        VStack (spacing: CommonConstants.contentStackSpacing) {
            InputView(title: "Title", text: $title, hint: "enter title...", keyboardType: .default, inputType: .normal)
            TaskDescriptionView(text: $description)
            DatePickerTextField(deadline: $deadlineDate, title: "Deadline date", text: "select date...")
        }
        .padding(.top, CommonConstants.topSpace)
        .padding(.horizontal, Grid.stripe)
        Spacer()
        ButtonView(title: "Create") {
            print("im here")
            viewModel.insertTask(email: viewModel.getUser()?.email ?? "", task: Task(name: title, description: description, deadlineDate: deadlineDate))
        }
        .padding(.bottom, Grid.stripe * 2)
        .padding(.horizontal, Grid.stripe * 2)
        .navigationBarTitle("Create task")
        .onAppear() {
            self.viewModel.fetchData()
        }
    }
        
}

struct NTP: PreviewProvider {
    static var previews: some View {
        NewTaskPageView()
    }
}
