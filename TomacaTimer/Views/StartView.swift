import SwiftUI
import AlertToast

struct StartView: View {
    var viewModel: TimerViewModel
    @State private var task: String = ""
    @State private var showToast = false
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            TextField("Escribe tu tarea", text: self.$task)
            .padding()
            .shadow(color: Color.gray, radius: 15, x: 10, y: 10)
            .font(.custom("Open Sans", size: 18))
            .border(Color.gray)
            .background(Color.white)
            .padding()
            
            Button("⏱ EMPEZAR"){
                if task != "" { viewModel.setAndStart(task: task) }
                else { self.showToast = true }
            }.padding()
            .frame(width: 250)
            .background(Color(red: 0.9, green: 0.2, blue: 0.1))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(color: Color.gray, radius: 1, x: 2, y: 2)
            Button("⚙️ AJUSTES"){
                viewModel.settings()
            }.padding()
            .frame(width: 250)
            .background(Color(red: 0.4, green: 0.6, blue: 0.9))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(color: Color.gray, radius: 1, x: 2, y: 2)
            Button("⚙️ PROGRESO"){
                viewModel.settings()
            }.padding()
            .frame(width: 250)
            .background(Color(red: 0.4, green: 0.6, blue: 0.9))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(color: Color.gray, radius: 1, x: 2, y: 2)

        }.frame(maxHeight: .infinity)
            .background(Color(red: 0.9, green: 1, blue: 1))
            
        .toast(isPresenting: $showToast, duration: 3){
            AlertToast(displayMode: .hud, type: .regular, title: "⚠️ Necesitas escribir la tarea")
        }
       
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(viewModel: TimerViewModel())
    }
}

