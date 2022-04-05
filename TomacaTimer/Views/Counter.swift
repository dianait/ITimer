import SwiftUI
import Combine
import AlertToast

struct Counter: View {
    var viewModel: TimerViewModel
    @State var timeRemaing: Int
    var goTo: (_ time: Int, _ isCompleted: Bool) -> Void
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    @State var isPaused: Bool = false
    @State private var showToast = false
    @State private var showToastTaskSaved = false
    @State private var showToastNoTask = false
    
    @State private var task: String = ""
    
    var body: some View {
        VStack {
            Text(self.viewModel.workSession.progress).padding()
            Spacer()
            if (!viewModel.workSession.isTaskSave) {
                InputView(placeHolder: "Escribe tu tarea 🚀", task: self.$task)
            } else {
                TitleView(title: self.viewModel.workSession.currentStateTitle, task: self.viewModel.workSession.task, timeRemaing: $timeRemaing)
            }
            ControllersView(showToast: $showToast, timeRemaing: $timeRemaing, instantiateTimer: self.instantiateTimer, cancelTimer: self.cancelTimer, goTo: self.next)
            Spacer()
            Image("logo")
                .resizable()
                .frame(width: 60, height: 60, alignment: .leading)
        }.background(Color("Secondary"))
        .onReceive(timer) { _ in
            self.update()
        }.onAppear {
            if (self.viewModel.workSession.counterMain > 0) { self.instantiateTimer() }
        }
        .toast(isPresenting: $showToast, duration: 1){
            AlertToast(displayMode: .hud, type: .regular, title: "⏳ Bloque terminado")
        }
        .toast(isPresenting: $showToastTaskSaved, duration: 1){
            AlertToast(displayMode: .hud, type: .regular, title: "📚 Tarea Guardada")
        }
        .toast(isPresenting: $showToastNoTask, duration: 1){
            AlertToast(displayMode: .hud, type: .regular, title: "⚠️ Escribe una tarea")
        }
    }
    
    private func next() {
        self.cancelTimer()
        self.showToast = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.goTo(self.timeRemaing, false)
        }
    }
    
    private func update() {
        self.timeRemaing -= 1
        if self.timeRemaing == 0 {
            self.cancelTimer()
            self.showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                goTo(self.timeRemaing, true)
            }
        }
    }
    
    private func instantiateTimer() {
        if (!viewModel.workSession.isTaskSave) { self.saveTask() }
            self.isPaused = false
            self.timer = Timer.publish(every: 1, on: .main, in: .common)
            self.connectedTimer = self.timer.connect()
            return
    }
    
    private func saveTask() {
        if (self.task != "") {
            viewModel.saveTask(task: self.task)
        }
        else {
            self.showToastNoTask = true
        }
      
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
