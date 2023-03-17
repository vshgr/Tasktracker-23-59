//
//  ProfileInfoView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI
import Firebase

struct ProfileInfoView: View {
    
    // MARK: - Constants
    enum Constants {
        static let picWH: CGFloat = 75
    }
    
    // MARK: - Properties
    private let user = User()
    @ObservedObject var viewModel = AppViewModel()
    
    
    // MARK: - View
    var body: some View {
        HStack(spacing: CommonConstants.contentStackSpacing) {
            VStack(alignment: .leading) {
                Text(viewModel.getUser()?.name ?? "")
                    .font(.dl.ralewayBold(20))
                Text("@\(viewModel.getUser()?.username ?? "")")
                    .font(.system(size: 14))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(user.profilePicUrl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.picWH, height: Constants.picWH)
        }
        .onAppear() {
            self.viewModel.fetchData()
        }
    }
}

struct ProfileInfoView_Previews: PreviewProvider {
    static let viewModel = AppViewModel()
    
    static var previews: some View {
        ProfileInfoView()
    }
}
