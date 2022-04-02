import Foundation

enum TimerState {
    case idle
    case start(WorkSession)
    case shortPause(WorkSession)
    case longPause(WorkSession)
    case finish(WorkSession)
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
        self.workSession.currentState = "shortPause"
        self.state = .shortPause(self.workSession)
    }
    
    private func longPause() -> Void {
        self.workSession.currentState = "longPause"
        self.state = .longPause(self.workSession)
    }
    
    func start(time: Int) -> Void {
        self.workSession.currentState = "work"
        if self.workSession.counterMain >= 1 {
            let timePass = self.workSession.timerConfig.shortBreakTime - time
            self.workSession.totalTime += timePass
            self.workSession.progress = updateProgress(isComplete: true)        }
        self.workSession.currentStateTitle = "👩‍💻 A trabajar..."
        if self.workSession.counterMain < 4 {
            self.workSession.counterMain += 1
        }
        self.state = .start(self.workSession)
    }
    
    func pause(time: Int){
        let timePass = self.workSession.timerConfig.mainTime - time
        self.workSession.totalTime += timePass
        self.workSession.currentState = "☕️ Descanso"
        self.workSession.progress = updateProgress(isComplete: true)
        if workSession.counterMain < 4 {
            shortPause()
            return
        }
        longPause()
    }
    
    func finish(time: Int) -> Void {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd'-'MM'-'YYY'"
        let date = dateFormatter.string(from: self.workSession.date)
        self.workSession.dateString = date
        let timePass = self.workSession.timerConfig.mainTime - time
        self.workSession.totalTime += timePass
        self.workSession.totalTimeString = timeString(time: self.workSession.totalTime)
        self.state = .finish(self.workSession)
    }
    
    func saveTaskName(task: String) -> Void {
        self.workSession.task = task
        self.start(time: 0)
    }
    
    func timeString(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}
