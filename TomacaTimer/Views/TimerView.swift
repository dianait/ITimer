import SwiftUI

struct TimerView: View {
    @StateObject var viewModel = TimerViewModel()
    var body: some View {
        VStack{
              switch viewModel.state {
              case .idle:
                StartView(viewModel: viewModel)
              case .start(let workSession):
                  Counter(workSession: workSession,
                          minutes: workSession.timerConfig.mainTime,
                          goTo: viewModel.pause)
              case .shortPause(let workSession):
                  Counter(workSession: workSession,
                          minutes: workSession.timerConfig.shortBreakTime,
                          goTo: viewModel.start)
              case .longPause(let workSession):
                  Counter(workSession: workSession,
                          minutes: workSession.timerConfig.longBreakTime,
                          goTo: viewModel.finish)
              case .finish:
                  Text("Finish")
              }
          }
    }
}

