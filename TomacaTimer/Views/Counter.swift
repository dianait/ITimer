import SwiftUI
import Combine
import AlertToast

struct Counter: View {
    var workSession: WorkSession
    @State var timeRemaing: Int
    var goTo: (_ time: Int, _ isCompleted: Bool) -> Void
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    @State var isPaused: Bool = false
    @State private var showToast = false
    
    var body: some View {
        VStack {
            Text(self.workSession.progress).padding()
            Spacer()
            TitleView(title: self.workSession.currentStateTitle, task: self.workSession.task, timeRemaing: $timeRemaing)
            VStack{
                if isPaused { ButtonView(text: "▶️ CONTINUAR", handle: self.instantiateTimer ) }
                else { ButtonView(text: "⏸ PAUSAR", handle: self.cancelTimer ) }
                ButtonView(text: "⏩ SIGUIENTE", handle: {
                    self.cancelTimer()
                    self.showToast = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.goTo(self.timeRemaing, false)
                    }
                })
            }.font(.system(size: 20))
            
            Spacer()
            
                Image("logo")
                .resizable()
                .padding()
                .frame(width: 90, height: 90, alignment: .leading)
        }.background(Color("Secondary"))
        .onAppear {
            self.instantiateTimer()
        }.onDisappear {
            self.cancelTimer()
        }.onReceive(timer) { _ in
            self.timeRemaing -= 1
            if self.timeRemaing == 0 {
                self.cancelTimer()
                self.showToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    goTo(self.timeRemaing, true)
                }
            }
        }.toast(isPresenting: $showToast, duration: 1){
            AlertToast(displayMode: .hud, type: .regular, title: "⏳ Bloque terminado")
            // https://github.com/elai950/AlertToast
            // https://medium.com/swlh/presenting-apples-music-alerts-in-swiftui-7f5c32cebed6
        }
    }
    
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
}
