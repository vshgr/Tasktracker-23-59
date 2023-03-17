//
//  NewTaskPage.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 17.03.2023.
//

import Foundation

import SwiftUI

struct NewTaskPageView: View {
    
    @State private var title: String = ""
    @State private var deadline: Date = Date()
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            VStack (spacing: CommonConstants.contentStackSpacing) {
                InputView(title: "Title", text: $title, hint: "enter title...", keyboardType: .default, inputType: .normal)
                DatePickerTextField(title: "Deadline date", type: .date, text: "select date...")
                DatePickerTextField(title: "Deadline time", type: .time, text: "select time...")
            }
            .padding(.top, CommonConstants.topSpace)
            .padding(.horizontal, Grid.stripe)
            Spacer()
            ButtonView(title: "Continue")
                .padding(.bottom, Grid.stripe * 2)
                .padding(.horizontal, Grid.stripe * 2)
            .navigationBarTitle("Create task")
        } 
    }
}

struct NTP: PreviewProvider {
    static var previews: some View {
        NewTaskPageView()
    }
}
