import SwiftUI

struct ButtonView: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(text){
            action()
        }.padding()
        .frame(width: 200)
        .background(Color(red: 0.9, green: 0.2, blue: 0.1))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(color: Color.gray, radius: 1, x: 2, y: 2)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "BOTON", action: { print("Hola!") })
    }
}
