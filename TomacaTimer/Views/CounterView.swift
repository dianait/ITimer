import SwiftUI

struct CounterView: View {
    var viewModel: TimerViewModel
    var workSession: WorkSession
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining: Int = 0
    
    init(workSession: WorkSession, viewModel: TimerViewModel) {
        self.workSession = workSession
        self.viewModel = viewModel
        self.timeRemaining = 30
    }
    
    func getTime() -> Int{
        switch workSession.currentState {
        case "main":
            return workSession.timerConfig.mainTime
        case "short" :
            return workSession.timerConfig.shortBreakTime
        case "long":
            return workSession.timerConfig.longBreakTime
        default:
            print("Ha petao 🧨")
            return 0
        }
    }
    
    func whatsNext() -> Void {
        switch workSession.currentState {
        case "main":
            viewModel.pause()
        case "short" :
            viewModel.start()
        case "long":
            viewModel.finish()
        default:
            print("Ha petao 🧨")
        }
    }

    var body: some View {
        Text("\(timeRemaining)")
            .fontWeight(.semibold)
            .font(.title)
            .onReceive(self.timer) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
                else {
                   whatsNext()
                }
            }.frame(maxWidth: .infinity)
            .padding()
        }
    }


