//
//  Color+.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

extension Color {
    enum dl {
        static func mainCol() -> Color {
            Color("green")
        }
        
        static func attentionCol() -> Color {
            Color("red")
        }
        
        static func hintCol() -> Color {
            Color("hint")
        }
    }
}

extension Color {
   init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0)
   }

   init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

