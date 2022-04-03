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
            InputView(placeHolder: "Escribe tu tarea 🚀", task: self.$task)
            ButtonView(text: "⏱ EMPEZAR", handle: {
                if task != "" { viewModel.setAndStart(task: task) }
                else { self.showToast = true }
            })
            ButtonView(text: "⚙️ AJUSTES", handle: { viewModel.settings() })
            ButtonView(text: "🚀 PROGRESO", handle: {})

        }.frame(maxHeight: .infinity)
            .background(Color("Secondary"))
            
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

