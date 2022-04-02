import SwiftUI
import Combine

struct Counter: View {
    @State var seconds: Int = 0
    @State var minutes: Int
    var goTo: () -> Void
    var progress: String
    var task: String
    var currentState: String
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    @State var isPaused: Bool = false
    
    func instantiateTimer() {
           self.isPaused = false
           self.timer = Timer.publish(every: 1, on: .main, in: .common)
           self.connectedTimer = self.timer.connect()
           return
       }
       
       func cancelTimer() {
           self.isPaused = true
           self.connectedTimer?.cancel()
           return
       }
       
       func resetCounter() {
           self.minutes = 0
           return
       }
       
       func restartTimer() {
           self.minutes = 1 * 60
           self.cancelTimer()
           self.instantiateTimer()
           return
       }
    
       func timeString(time: Int) -> String {
           let minutes = Int(time) / 60 % 60
           let seconds = Int(time) % 60
           return String(format:"%02i:%02i", minutes, seconds)
       }
    
    var body: some View {
        VStack {
            Text(self.progress).padding()
            Spacer()
            Text(self.currentState).font(.title)
            if self.currentState != "☕️ Descanso" {
                Text(self.task).font(.title2)
            }
            Text("\(timeString(time: self.minutes))")
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
                Button("⏩"){}
            }.font(.largeTitle)
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
            self.minutes -= 1
        }
    }
}

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        Counter(minutes: 30, goTo: { print("") }, progress: "25 5 25 5 25 5 25 15", task: "Refactor ChatList", currentState: "👩‍💻 A trabajar...")
    }
}
