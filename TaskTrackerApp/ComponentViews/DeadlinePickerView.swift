import SwiftUI

struct DatePickerTextField: View {
    @Binding var deadline: Date
    var title: String
    @State var text: String
    @State private var isDatePickerPresented = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 11) {
            Text(title)
                .foregroundColor(.black)
                .font(.system(size: 17))
            Text(text)
                .foregroundColor(.dl.hintCol())
                .onTapGesture {
                    isDatePickerPresented = true
                }
                .sheet(isPresented: $isDatePickerPresented) {
                    DatePicker("", selection: $deadline, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.hidden)
                        .onChange(of: deadline, perform: { newValue in
                            text = deadline.formatted()
                        })
                }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.black)
        }
        .padding(.vertical, 8)
    }
}

//struct DL: PreviewProvider {
//    static var previews: some View {
//        DatePickerTextField(title: "Deadline date", type: .time, text: "select")
//    }
//}
