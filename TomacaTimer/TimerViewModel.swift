import Foundation


struct TimerConfig {
    let mainTime: Int = 5
    let shortBreakTime: Int = 2
    var longBreakTime: Int = 3
    let rounds: Int = 1 // Number of sequences
    let sequence: [String] = ["main", "short", "main", "short", "main", "short", "main", "long"]
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
    case longPause(WorkSession)
    case finish
}

class TimerViewModel: ObservableObject {
    @Published var state: TimerState = .idle
    var workSession: WorkSession
    
    init(){
        self.workSession = WorkSession()
    }
    
    func start() -> Void {
        self.workSession.currentState = "main"
        self.workSession.counterMain += 1
        self.state = .start(self.workSession)
    }
    
    func pause(){
        if workSession.counterMain < 4 {
            shortPause()
            return
        }
        longPause()
    }
    
    private func shortPause() -> Void {
        self.workSession.currentState = "short"
        self.workSession.counterShort += 1
        self.state = .shortPause(self.workSession)
    }
    
    private func longPause() -> Void {
        self.workSession.currentState = "long"
        self.workSession.counterLong += 1
        self.state = .longPause(self.workSession)
    }
    
    func finish() -> Void {
        self.state = .finish
    }
}
