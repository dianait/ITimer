import SwiftUI

struct StartView: View {
    var viewModel: TimerViewModel
    @State private var task: String = ""
    var body: some View {
        TextField("Your name", text: self.$task)
        .padding()
        Button("START"){
            viewModel.start()
        }
    }
}

