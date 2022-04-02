import SwiftUI
import AlertToast

struct SettingsView: View {
    @State private var longBrake = 15
    var longBrakeOptions = [15, 30]
    var viewModel: TimerViewModel
    @State private var showToast = false
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("El pomodoro medirá intervalos formados por 4 bloques de trabajo de 25 minutos con 5 minutos de descanso entre ellos. Cada tres bloques de descanso de 5 minutos, el cuarto será de 15 minutos o 30 minutos. Así que te toca elegir 👇").padding()
            HStack {
                Text("Pausa larga 👉").padding()
                Picker("Please choose a your long break", selection: $longBrake) {
                    ForEach(longBrakeOptions, id: \.self) {
                        Text("⏳\($0)").tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            Button("💾 GUARDAR"){
                self.showToast = true
                viewModel.updateLongBrake(longBrake: longBrake)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    viewModel.initialize()
                }
            }
                
        }  .toast(isPresenting: $showToast, duration: 1){
            AlertToast(displayMode: .hud, type: .regular, title: "💾 Pausa guardada")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: TimerViewModel())
    }
}
