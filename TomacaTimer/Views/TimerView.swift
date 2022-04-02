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
                          timeRemaing: workSession.timerConfig.mainTime,
                          goTo: { time in viewModel.pause(time: time) })
              case .shortPause(let workSession):
                  Counter(workSession: workSession,
                          timeRemaing: workSession.timerConfig.shortBreakTime,
                          goTo: { time in viewModel.start(time: time) })
              case .longPause(let workSession):
                  Counter(workSession: workSession,
                          timeRemaing: workSession.timerConfig.longBreakTime,
                          goTo: { time in viewModel.finish(time: time) })
              case .finish(let workSession):
                  FinishView(date: workSession.dateString, totalTime: workSession.totalTimeString)
              }
          }
    }
}

