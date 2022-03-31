import SwiftUI

struct TimerView: View {
    @StateObject var viewModel = TimerViewModel()
    var body: some View {
        VStack{
              switch viewModel.state {
              case .idle:
                StartView(viewModel: viewModel)
              case .start(let workSession):
                  Text("Work session")
                  CounterView(timeRemaining: workSession.timerConfig.mainTime)
              case .shortPause(let workSession):
                  Text("Short pause")
                  CounterView(timeRemaining: workSession.timerConfig.shortBreakTime)
              case .LongPause(let workSession):
                  Text("Long pause")
                  CounterView(timeRemaining: workSession.timerConfig.longBreakTime)
              case .finish:
                  Text("Finish")
              }
          }
    }
}

