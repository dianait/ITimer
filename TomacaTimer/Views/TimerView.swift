import SwiftUI

struct TimerView: View {
    @StateObject var viewModel = TimerViewModel()
    var body: some View {
        VStack{
              switch viewModel.state {
              case .idle:
                StartView(viewModel: viewModel)
              case .start(let workSession):
                  Text("Doing... \(workSession.task)")
                  Text("Main time \(workSession.counterMain)")
                  Counter(viewModel: viewModel,
                          minutes: workSession.timerConfig.mainTime,
                          goTo: viewModel.pause)
              case .shortPause(let workSession):
                  Text("Doing... \(workSession.task)")
                  Text("Short pause \(workSession.counterShort)")
                  Counter(viewModel: viewModel,
                          minutes: workSession.timerConfig.shortBreakTime,
                          goTo: viewModel.start)
              case .longPause(let workSession):
                  Text("Doing... \(workSession.task)")
                  Text("Long pause \(workSession.counterLong)")
                  Counter(viewModel: viewModel,
                          minutes: workSession.timerConfig.longBreakTime,
                          goTo: viewModel.finish)
              case .finish:
                  Text("Finish")
              }
          }
    }
}

