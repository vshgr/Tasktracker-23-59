//
//  ProfileInfoView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

struct ProfileInfoView: View {
    // MARK: - Constants
    enum Constants {
        static let picWH: CGFloat = 75
    }
    
    // MARK: - Properties
    private let user = User()
    @EnvironmentObject var viewModel: AppViewModel
    
    
    // MARK: - View
    var body: some View {
        HStack(spacing: CommonConstants.contentStackSpacing) {
            VStack(alignment: .leading) {
                Text("\(viewModel.getName())")
                    .font(.dl.ralewayBold(20))
                Text("@\(viewModel.getUserName())")
                    .font(.system(size: 14))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(user.profilePicUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.picWH, height: Constants.picWH)
        }
    }
}

struct ProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoView()
    }
}

