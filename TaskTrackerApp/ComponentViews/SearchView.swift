//
//  SearchView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 25.03.2023.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    var buttonClicked: (() -> Void)?

    // MARK: - Body
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
            VStack {
                TextField("search...", text: $text)
                    .foregroundColor(.black)
                    .accentColor(.black)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black)
            }
            Button {
                buttonClicked?()
                text = ""
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
            }
        }
    }
}

//struct SearchViewpr: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
