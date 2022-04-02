import SwiftUI

struct StartView: View {
    var viewModel: TimerViewModel
    @State private var task: String = ""
    @State private var longBrake = 15
    var longBrakeOptions = [15, 30]
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("¿De cuanto quieres la pausa larga?")
            Picker("Please choose a your long break", selection: $longBrake) {
                ForEach(longBrakeOptions, id: \.self) {
                    Text("⏳\($0)").tag($0)
                }
            }
            
            TextField("what you want to do?", text: self.$task)
            .padding()
            .shadow(color: Color.gray, radius: 15, x: 10, y: 10)
            .font(.custom("Open Sans", size: 18))
            .frame(width: 250)
            .border(Color.gray)
            
            Button("⏱ START"){
                viewModel.setAndStart(longBrake: longBrake, task: task)
            }.padding()
            .frame(width: 250)
            .background(Color(red: 0.9, green: 0.2, blue: 0.1))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(color: Color.gray, radius: 1, x: 2, y: 2)
        }
       
    }
}


struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(viewModel: TimerViewModel())
    }
}

