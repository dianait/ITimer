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
                          goTo: viewModel.pause, task: workSession.task,
                          progress: workSession.progress)
              case .shortPause(let workSession):
                  Counter(minutes: workSession.timerConfig.shortBreakTime,
                          goTo: viewModel.start, task: workSession.task,
                          progress: workSession.progress)
              case .longPause(let workSession):
                  Counter(minutes: workSession.timerConfig.longBreakTime,
                          goTo: viewModel.finish, task: workSession.task,
                          progress: workSession.progress)
              case .finish:
                  Text("Finish")
              }
          }
    }
}

