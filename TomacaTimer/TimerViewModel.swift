import Foundation

/* mainTime --- shortBreakTime --- mainTime --- shortBreakTime --- mainTime --- LongBreakTime */


struct TimerConfig {
    let mainTime: Int = 25
    let shortBreakTime: Int = 5
    var longBreakTime: Int = 30
    let rounds: Int = 1
}

struct WorkSession {
    var timerConfig: TimerConfig = TimerConfig()
    var counterMain: Int = 0
    var counterShort: Int = 0
    var counterLong: Int = 0
    let task: String = ""
    var totalTime: Int = 0
    var date: Date = Date.now
    var currentState: String = "main"
}

enum TimerState {
    case idle
    case start(WorkSession)
    case shortPause(WorkSession)
    case LongPause(WorkSession)
    case finish
}

class TimerViewModel: ObservableObject {
    @Published var state: TimerState = .idle
    var workSession: WorkSession
    
    init(){
        self.workSession = WorkSession()
    }
    
    func start() -> Void {
        self.workSession.counterMain += 1
        self.state = .start(self.workSession)
    }
    
    func shortPause() -> Void {
        self.workSession.currentState = "short"
        self.workSession.counterShort += 1
        self.state = .shortPause(self.workSession)
    }
    
    func longPause() -> Void {
        self.workSession.currentState = "long"
        self.workSession.counterLong += 1
        self.state = .LongPause(self.workSession)
    }
}
