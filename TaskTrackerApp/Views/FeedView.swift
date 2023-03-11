//
//  FeedView.swift
//  TaskTrackerApp
//
//  Created by Алиса Вышегородцева on 11.03.2023.
//

import SwiftUI

struct FeedView: View {
    let developmentComponent = DevelopmentComponent()
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            developmentComponent
                .padding()
            
        }
    }
}

