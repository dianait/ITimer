import SwiftUI

struct InputView: View {
    @State private var task: String = ""
    
    var body: some View {
        TextField("what you want to do?", text: self.$task)
        .padding()
        .shadow(color: Color.gray, radius: 15, x: 10, y: 10)
        .font(.custom("Open Sans", size: 18))
        .frame(width: 250)
        .border(Color.gray)
    }
}
