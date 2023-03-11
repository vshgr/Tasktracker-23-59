//
//  FriendsComponent.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

struct FriendHeaderView: View {
    // MARK: - Constants
    enum Constants {
        static let imageWidth: CGFloat = 36
    }
    
    // MARK: - Fields
    private let user = User()
    private let image: Image
    private let name: Text
    
    init() {
        image = Image(user.profilePicUrl)
        name = Text(user.name).foregroundColor(.black)
            .font(.dl.ralewayMedium(15))
    }
    // MARK: - Configuration
    var body: some View {
        HStack(spacing: CommonConstants.smallContentSpacing) {
            image
                .resizable()
                .frame(width: Constants.imageWidth, height: Constants.imageWidth)
            name
        }
    }
}

struct F: PreviewProvider {
    static var previews: some View {
        FriendHeaderView()
    }
}

