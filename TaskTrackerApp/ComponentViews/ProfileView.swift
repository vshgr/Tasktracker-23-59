//
//  ProfileView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - Constants
    private enum Constants {
        static let logo: Image = Image("logo")
        static let photoWidth: CGFloat = 146
        static let buttonTitle: String = "add photo"
        static let backImageViewColor: Color = Color.dl.mainCol()
        static let buttonImage: Image = Image("photo")
    }
    
    // MARK: - Fields
    @State private var photoAreaImage: Image = Constants.logo
    
    var tapChangePic: (() -> Void)?
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: CommonConstants.smallContentSpacing) {
            photoArea
            
            Button(action: {
                tapChangePic?()
            }, label: {
                HStack (alignment: .center) {
                    Text(Constants.buttonTitle)
                        .font(.dl.ralewayBold(15))
                    Constants.buttonImage
                        .renderingMode(.template)
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .cornerRadius(Constants.photoWidth / 2)
            })
            .buttonStyle(PlainButtonStyle())
            .font(CommonConstants.mainLabelFont)
        }
        .padding(.horizontal)
    }
    
    private var photoArea: some View {
        Constants.logo
            .frame(width: Constants.photoWidth, height: Constants.photoWidth)
            .background(Constants.backImageViewColor)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Constants.backImageViewColor, lineWidth: 2)
            )
            .onTapGesture {
                tapChangePic?()
            }
    }
}

struct prof: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
