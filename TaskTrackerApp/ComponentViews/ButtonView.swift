import SwiftUI

struct ButtonView: View {
    // MARK: - Fields
    var buttonClicked: (() -> Void)?
    var title: String
    var height: CGFloat

    // MARK: - Body
    var body: some View {
        Button(action: {
            buttonClicked?()
        }, label: {
            Text(title)
                .font(.dl.mainFont())
                .foregroundColor(.white)
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .background(Color.black)
                .cornerRadius(height / 2)
        })
    }
    
    // MARK: - Inits
    init(title: String, height: CGFloat = 70, buttonClicked: (() -> Void)? = nil) {
        self.title = title
        self.height = height
        self.buttonClicked = buttonClicked
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Sign In")
    }
}
