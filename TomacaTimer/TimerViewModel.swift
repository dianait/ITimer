import Foundation

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

    private func shortPause() -> Void {
        self.workSession.counterShort += 1
        self.state = .shortPause(self.workSession)
    }
    
    private func longPause() -> Void {
        self.workSession.counterLong += 1
        self.state = .longPause(self.workSession)
    }
    
    func start() -> Void {
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
    
    func finish() -> Void {
        self.state = .finish
    }
    
    func saveTaskName(task: String) -> Void {
        self.workSession.task = task
    }
}
