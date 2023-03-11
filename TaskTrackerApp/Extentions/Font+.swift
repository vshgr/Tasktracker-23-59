//
//  Font+.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

extension Font {
    enum dl {
        private static let mainFont: String = "FONTSPRINGDEMO-PontiacBoldRegular"
        private static let ralewayRegular: String = "Raleway-Regular"
        private static let ralewayMedium: String = "Raleway-Medium"
        private static let ralewayBold: String = "Raleway-Bold"
        
        static func mainFont(_ size: CGFloat = 16) -> Font {
            return Font.custom(mainFont, size: size)
        }
        
        static func ralewayRegular(_ size: CGFloat = 16) -> Font {
            return Font.custom(ralewayRegular, size: size)
        }
        
        static func ralewayMedium(_ size: CGFloat = 14) -> Font {
            return Font.custom(ralewayMedium, size: size)
        }
        
        static func ralewayBold(_ size: CGFloat = 20) -> Font {
            return Font.custom(ralewayBold, size: size)
        }
    }
}

