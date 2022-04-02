import SwiftUI

struct TimerView: View {
    @StateObject var viewModel = TimerViewModel()
    var body: some View {
        VStack{
              switch viewModel.state {
              case .idle:
                StartView(viewModel: viewModel)
              case .start(let workSession):
                  Counter(minutes: workSession.timerConfig.mainTime,
                          goTo: viewModel.pause,
                          progress: workSession.progress,
                          task: workSession.task,
                          currentState: workSession.currentState)
              case .shortPause(let workSession):
                  Counter(minutes: workSession.timerConfig.shortBreakTime,
                          goTo: viewModel.start,
                          progress: workSession.progress,
                          task: workSession.task,
                          currentState: workSession.currentState)
              case .longPause(let workSession):
                  Counter(minutes: workSession.timerConfig.longBreakTime,
                          goTo: viewModel.finish,
                          progress: workSession.progress,
                          task: workSession.task,
                          currentState: workSession.currentState)
              case .finish:
                  Text("Finish")
              }
          }
    }
}

