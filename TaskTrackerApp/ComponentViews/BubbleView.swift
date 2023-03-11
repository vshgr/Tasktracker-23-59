//
//  BubbleView.swift
//  SwiftUITest
//
//  Created by Алиса Вышегородцева on 10.03.2023.
//

import SwiftUI

struct BubbleView: View {
    // MARK: - Constants
    enum Constants {
        static let width: CGFloat = 20
        static let numOfLines: Int = 1
    }
    
    // MARK: - Fields
    @State var bubbleText: String
    @State var bubbleSelected: Bool = false
    @State var isInteractable: Bool
    
    private func getTextSize() -> CGSize {
        print(bubbleText.size(withAttributes: [.font: UIFont.systemFont(ofSize: 12)]).width)
        return bubbleText.size(withAttributes: [.font: UIFont.systemFont(ofSize: 12)])
    }
    
    // MARK: - Configuration
    private func configureUI() -> some View {
        Text(bubbleText)
            .foregroundColor(bubbleSelected ? .white : .black)
            .font(.system(size: 12, weight: .bold, design: .default))
            .multilineTextAlignment(.center)
            .lineLimit(Constants.numOfLines)
            .frame(width: getTextSize().width + Constants.width * 2,
                   height: getTextSize().height + Constants.width)
            .background(bubbleSelected ? Color.black : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(Color.black, lineWidth: 2)
            )
            .cornerRadius(100)
            .onTapGesture(perform: bubbleClicked)
        
        
    }
    
    var body: some View {
        if isInteractable {
            configureUI()
        } else {
            Text(bubbleText)
                .foregroundColor(.black)
                .font(.system(size: 12, weight: .bold, design: .default))
                .multilineTextAlignment(.center)
                .lineLimit(Constants.numOfLines)
                .frame(width: getTextSize().width + Constants.width * 2,
                       height: getTextSize().height + Constants.width)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.black, lineWidth: 2)
                )
                .cornerRadius(100)
        }
    }
    
    // MARK: - Getters
    public func getText() -> String {
        return bubbleText
    }
    
    // MARK: - Setters
    private func setSelected() {
        bubbleSelected = true
    }
    
    private func setUnselected() {
        bubbleSelected = false
    }
    
    // MARK: - Actions
    private func bubbleClicked() {
        if bubbleSelected == true {
            setUnselected()
        } else {
            setSelected()
        }
    }
}

struct B: PreviewProvider {
    static var previews: some View {
        BubbleView(bubbleText: "Hello", isInteractable: true)
    }
    
}

