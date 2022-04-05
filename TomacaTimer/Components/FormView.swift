import SwiftUI

struct InputView: View {
    let placeHolder: String
    @Binding var task: String
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: self.$task)
            .font(.custom("Open Sans", size: 18))
            .background(Color("White"))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(placeHolder: "Escribe tu tarea 🎉", task: .constant("Jinkobot"))
    }
}

