//
//  TaskDescriptionView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 17.03.2023.
//

import Foundation
import SwiftUI

struct TaskDescriptionView: View {
    @Binding var text: String
    
    enum Constants {
        static let underlineSpacind: CGFloat = 8
        static let errorSpacing: CGFloat = 11
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: Constants.errorSpacing) {
            Text("Description")
                .foregroundColor(.black)
                .font(.system(size: 17))
            TextField("enter description...", text: $text, axis: .vertical)
                .foregroundColor(.black)
                .keyboardType(.default)
                .lineLimit(5)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black)
        }
        .padding(.vertical, Constants.underlineSpacind)
    }
}

//struct DV: PreviewProvider {
//    static var previews: some View {
//        TaskDescriptionView()
//    }
//}
