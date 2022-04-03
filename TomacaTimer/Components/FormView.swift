import SwiftUI

struct InputView: View {
    let placeHolder: String
    @Binding var task: String
    
    var body: some View {
        TextField(placeHolder, text: self.$task)
        .padding()
        .shadow(color: Color.gray, radius: 15, x: 10, y: 10)
        .font(.custom("Open Sans", size: 18))
        .border(Color.gray)
        .background(.white)
        .padding()
    }
}

