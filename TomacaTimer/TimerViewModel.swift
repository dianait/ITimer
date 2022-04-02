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
    
    private func updateProgress(isComplete: Bool) -> String {
        let symbol = isComplete ? self.workSession.timerConfig.completeSymbol : self.workSession.timerConfig.incompleteSymbol
        var progress = self.workSession.progress.split(separator: " ")
        var nextCursor: Int? = nil
        
        for i in 0..<progress.count {
            if (progress[i].contains(self.workSession.timerConfig.cursorSymbol)) {
                progress[i] = progress[i].dropLast()
                progress[i] += symbol
                nextCursor = i
            }
        }
        if let index = nextCursor {
            progress[index + 1] += self.workSession.timerConfig.cursorSymbol
        }
    return progress.joined(separator: " ")
    }
    
    private func shortPause() -> Void {
        self.workSession.currentState = "☕️ Descanso"
        self.state = .shortPause(self.workSession)
    }
    
    private func longPause() -> Void {
        self.workSession.currentState = "☕️ Descanso"
        self.state = .longPause(self.workSession)
    }
    
    func start() -> Void {
        if self.workSession.counterMain >= 1 {
            self.workSession.progress = updateProgress(isComplete: true)
        }
        self.workSession.currentState = "👩‍💻 A trabajar..."
        if self.workSession.counterMain < 4 {
            self.workSession.counterMain += 1
        }
        self.state = .start(self.workSession)
    }
    
    func pause(){
        self.workSession.progress = updateProgress(isComplete: true)
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
        self.start()
    }
}
