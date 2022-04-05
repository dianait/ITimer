import SwiftUI

struct InputView: View {
    let placeHolder: String
    @Binding var task: String
    
    var body: some View {
            TextField(placeHolder, text: self.$task)
            .font(.custom("Open Sans", size: 18))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
}

