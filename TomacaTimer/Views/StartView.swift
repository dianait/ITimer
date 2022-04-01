import SwiftUI

struct StartView: View {
    var viewModel: TimerViewModel
    @State private var task: String = ""
    var body: some View {
        InputView()
        .padding()
        ButtonView(text: "START", action: viewModel.start)
    }
}

