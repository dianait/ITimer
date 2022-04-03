import SwiftUI

struct ButtonView: View {
    var text: String
    var handle: ()-> Void
    
    var body: some View {
        Button(text){ handle() }
        .padding()
        .frame(width: 250)
        .background(Color("Primary"))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(color: Color("Terciary"), radius: 1, x: 2, y: 2)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "⚙️ SETTINGS", handle: { print("Settings button is clicked")})
    }
}
