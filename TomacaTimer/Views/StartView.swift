import SwiftUI

struct StartView: View {
    var viewModel: TimerViewModel
    @State private var task: String = ""
    
    var body: some View {
        VStack {
            TextField("what you want to do?", text: self.$task)
            .padding()
            .shadow(color: Color.gray, radius: 15, x: 10, y: 10)
            .font(.custom("Open Sans", size: 18))
            .frame(width: 250)
            .border(Color.gray)
            
            Button("START"){
                viewModel.saveTaskName(task: self.task)
                viewModel.start()
            }.padding()
            .frame(width: 200)
            .background(Color(red: 0.9, green: 0.2, blue: 0.1))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .shadow(color: Color.gray, radius: 1, x: 2, y: 2)
        }
       
    }
}

