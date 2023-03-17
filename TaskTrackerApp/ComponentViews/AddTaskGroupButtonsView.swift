//
//  AddButtonsView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 11.03.2023.
//

import SwiftUI

struct AddTaskGroupButtonsView: View {
    // MARK: - Constants
    enum Constants{
        static let width: CGFloat = 133
        static let imagePadding: CGFloat = 8.33
        static let shadowRadius: CGFloat = 5
    }
    
    @State var buttonClicked: Bool = false
    var addTaskClicked: (() -> Void)?
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .trailing, spacing: CommonConstants.horizontalStackSpacing) {
            if (buttonClicked) {
                ButtonView(title: "Add task", height: 40) {
                    print("hello there")
                    addTaskClicked?()
                }
                .frame(width: Constants.width)
                ButtonView(title: "Add group", height: 40)
                    .frame(width: Constants.width)
                Button(action: {
                    buttonClicked = false
                }, label: {
                    Image(systemName: "xmark")
                        .padding(Constants.imagePadding)
                        .background(Color.black)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                        .overlay(Circle().stroke(Color.black, lineWidth: 1))
                        .shadow(radius: Constants.shadowRadius)
                })
            } else {
                Button(action: {
                    buttonClicked = true
                }, label: {
                    Image(systemName: "plus")
                        .padding(Constants.imagePadding)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 1))
                        .shadow(radius: Constants.shadowRadius)
                })
            }
        }
    }
}



struct Ada: PreviewProvider {
    static var previews: some View {
        AddTaskGroupButtonsView()
    }
}

