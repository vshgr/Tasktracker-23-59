//
//  CustomBackButton.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 19.03.2023.
//

import SwiftUI

struct CustomBackButton: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                Text("go back")
                    .foregroundColor(.black)
                    .font(.dl.mainFont())
            }
        }
    }
    
}

struct Back: PreviewProvider {
    static var previews: some View {
        CustomBackButton()
    }
}
