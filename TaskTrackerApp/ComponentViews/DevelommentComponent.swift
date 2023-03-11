//
//  DevelommentComponent.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 11.03.2023.
//

import SwiftUI

struct DevelopmentComponent: View {
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: CommonConstants.contentStackSpacing) {
            Text("Section is under development")
                .font(.dl.mainFont(16))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, CommonConstants.contentStackSpacing)
                .padding(.horizontal,  CommonConstants.contentStackSpacing)
            Image("logo")
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, CommonConstants.contentStackSpacing)
                .padding(.bottom,  CommonConstants.contentStackSpacing)
        }
        .padding(.all, 10)
        .background(Color.white)
        .cornerRadius(CommonConstants.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: CommonConstants.cornerRadius)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

struct A: PreviewProvider {
    static var previews: some View {
        DevelopmentComponent()
    }
}
