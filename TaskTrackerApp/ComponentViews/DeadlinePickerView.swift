import SwiftUI

enum Types {
    case date
    case time
}

struct DatePickerTextField: View {
    @Binding var deadline: Date
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    var title: String
    var type: Types
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
                    if type == .date {
                        DatePicker("", selection: $deadline, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.hidden)
                            .onChange(of: deadline, perform: { newValue in
                                text = dateFormatter.string(from: deadline)
                            })
                    } else {
                        DatePicker("", selection: $deadline, displayedComponents:  .hourAndMinute)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                            .presentationDetents([.medium, .large])
                            .presentationDragIndicator(.hidden)
                            .onChange(of: deadline, perform: { newValue in
                                text = timeFormatter.string(from: deadline)
                            })
                    }
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
