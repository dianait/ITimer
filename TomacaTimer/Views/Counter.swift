import SwiftUI
import Combine

struct Counter: View {
    var workSession: WorkSession
    @State var seconds: Int = 0
    @State var timeRemaing: Int
    var goTo: (_ time: Int, _ isCompleted: Bool) -> Void
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    @State var isPaused: Bool = false
    
    private func instantiateTimer() {
           self.isPaused = false
           self.timer = Timer.publish(every: 1, on: .main, in: .common)
           self.connectedTimer = self.timer.connect()
           return
       }
       
    private func cancelTimer() {
           self.isPaused = true
           self.connectedTimer?.cancel()
           return
       }
       
    private func resetCounter() {
           self.timeRemaing = 0
           return
       }
       
    private func restartTimer() {
           self.timeRemaing = 1 * 60
           self.cancelTimer()
           self.instantiateTimer()
           return
       }
    
    private func timeString(time: Int) -> String {
           let minutes = Int(time) / 60 % 60
           let seconds = Int(time) % 60
           return String(format:"%02i:%02i", minutes, seconds)
       }
    
    var body: some View {
        VStack {
            Text(self.workSession.progress).padding()
            Spacer()
            Text(self.workSession.currentStateTitle).font(.title)
            Text(self.workSession.task).font(.title2)
            Text("\(timeString(time: self.timeRemaing))")
                .fontWeight(.semibold)
                .font(.system(size: 60))
                .frame(height: 80.0)
                .frame(maxWidth: .infinity)
                .padding()
            HStack{
                if isPaused {
                    Button("▶️"){
                        self.instantiateTimer()
                    }
                }
                else {
                    Button("⏸"){
                        self.cancelTimer()
                    }
                }
                Button("⏩"){
                    self.goTo(self.timeRemaing, false)
                }
            }.font(.system(size: 40))
            Spacer()
                Image("logo")
                .resizable()
                .padding()
                .frame(width: 90, height: 90, alignment: .leading)
        }.onAppear {
            self.instantiateTimer()
        }.onDisappear {
            self.cancelTimer()
        }.onReceive(timer) { _ in
            self.timeRemaing -= 1
            if self.timeRemaing == 0 {
                goTo(self.timeRemaing, true)
            }
        }
    }
}
