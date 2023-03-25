//
//  ProfileInfoView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI
import Firebase

struct ProfileInfoView: View {
    var name: String
    var username: String
    // MARK: - Constants
    enum Constants {
        static let picWH: CGFloat = 75
    }
    
    // MARK: - Properties
    private let user = User()
    
    // MARK: - View
    var body: some View {
        HStack(spacing: CommonConstants.contentStackSpacing) {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.dl.ralewayBold(20))
                Text("@\(username)")
                    .font(.system(size: 14))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("none")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.picWH, height: Constants.picWH)
        }
    }
}
