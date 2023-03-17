//
//  TaskOwnerView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 17.03.2023.
//

import SwiftUI

struct TaskOwnerView: View {
    // MARK: - Constants
    enum Constants {
        static let imageWidth: CGFloat = 36
    }
    
    // MARK: - Properties
    private let user = User()
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: CommonConstants.smallContentSpacing) {
            Image(user.profilePicUrl)
                .resizable()
                .frame(width: Constants.imageWidth, height: Constants.imageWidth)
                .aspectRatio(contentMode: .fit)
            Text(user.name)
                .foregroundColor(.black)
                .font(.dl.ralewayMedium(15))
        }
    }
}

struct FriendAccountSVConponent_Previews: PreviewProvider {
    static var previews: some View {
        TaskOwnerView()
    }
}
