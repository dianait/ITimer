import SwiftUI

struct CounterView: View {
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var workSession: WorkSession
    @State var timeRemaining: Int = 0
    var currentState: String = "main"
    
    init(workSession: WorkSession) {
        self.workSession = workSession
        self.timeRemaining = workSession.timerConfig.mainTime
        self.currentState = workSession.currentState
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
                
                }
            }.frame(maxWidth: .infinity)
            .padding()
        }
    }

