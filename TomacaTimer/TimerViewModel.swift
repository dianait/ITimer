import Foundation

enum TimerState {
    case idle
    case start(WorkSession)
    case settings
    case shortPause(WorkSession)
    case longPause(WorkSession)
    case finish(WorkSession)
}

class TimerViewModel: ObservableObject {
    @Published var state: TimerState = .idle
    var workSession: WorkSession
    var storage: StorageController
    var notificacition: Notification
    
    init(){
        self.workSession = WorkSession()
        self.storage = StorageController()
        self.notificacition = Notification()
    }
    
    // MARK: STATES
    func start(time: Int, isCompleted: Bool) -> Void {
        if workSession.counterMain > 0 {
            self.notificacition.display(state: self.workSession.currentState)
        }
        self.workSession.currentState = "work"
        let timePass = self.workSession.timerConfig.shortBreakTime - time
        self.workSession.totalTime += timePass
        self.workSession.progress = updateProgress(isComplete: isCompleted)
        self.workSession.currentStateTitle = self.workSession.timerConfig.workTitle
        self.workSession.counterMain += 1
        self.state = .start(self.workSession)
    }
    
    func pause(time: Int, isCompleted: Bool){
        self.notificacition.display(state: self.workSession.currentState)
        let timePass = self.workSession.timerConfig.mainTime - time
        self.workSession.totalTime += timePass
        self.workSession.currentStateTitle = self.workSession.timerConfig.BreakTitle
        self.workSession.progress = updateProgress(isComplete: isCompleted)
        if workSession.counterMain < 4 {
            shortPause()
            return
        }
        longPause()
    }
    
    func finish(time: Int) -> Void {
        let timePass = self.workSession.timerConfig.longBreakTime - time
        self.workSession.totalTime += timePass
        let indexDate = isDateIn()
        if (indexDate != -1) {
            storage.workList[indexDate].time += self.workSession.totalTime
        } else {
            storage.save(workList: storage.workList +
                [Work(task: self.workSession.task, date: self.workSession.date, time: self.workSession.totalTime)])
        }
        self.workSession.workList = storage.workList
        self.state = .finish(self.workSession)
    }
    
    private func shortPause() -> Void {
        self.workSession.currentState = "shortPause"
        self.state = .shortPause(self.workSession)
    }
    
    private func longPause() -> Void {
        self.workSession.currentState = "longPause"
        self.state = .longPause(self.workSession)
    }
    
    func initialize() -> Void {
        self.workSession = WorkSession()
        self.workSession.timerConfig.longBreakTime = storage.getLongBrake()
        self.state = .idle
    }
    
    func setAndStart(task: String) {
        saveTaskName(task: task)
        start(time: 0, isCompleted: false)
    }
    
    func settings() {
        self.state = .settings
    }
    
    
    // MARK: UPDATES
    private func updateProgress(isComplete: Bool) -> String {
        let symbol = isComplete ? self.workSession.timerConfig.completeSymbol : self.workSession.timerConfig.incompleteSymbol
        var progress = self.workSession.progress.split(separator: " ")
        if (self.workSession.counterMain > 0) {
            for i in 0..<progress.count {
                if (progress[i].contains(self.workSession.timerConfig.cursorSymbol)) {
                    progress[i] = progress[i].dropLast()
                    progress[i] += symbol
                    self.workSession.currentCursor = i
                }
            }
            
            if (self.workSession.counterMain < 5) {
                progress[self.workSession.currentCursor + 1] += self.workSession.timerConfig.cursorSymbol
            }
            
        }
        return progress.joined(separator: " ")
    }
    
    private func saveTaskName(task: String) -> Void {
        self.workSession.task = task
    }
    
    func updateLongBrake(longBrake: Int) {
        if longBrake * 60 != self.workSession.timerConfig.longBreakTime {
            self.workSession.timerConfig.longBreakTime = longBrake * 60
            storage.saveLongBrake(userLongBrake: longBrake)
        }
    }
    
    // MARK: UTILS
    func isDateIn() -> Int {
        let dateFromTheTask = getDateString(date:  self.workSession.date)
        for i in 0..<storage.workList.count {
            let dateFromTheWorkList = getDateString(date: storage.workList[i].date)
            if (dateFromTheWorkList == dateFromTheTask) {
                return i
            }
        }
        return -1
    }
    
    func workListString() -> [WorkString] {
        let works = self.workSession.workList
        var workString: [WorkString] = []
        for i in 0..<works.count {
            workString.append(WorkString(
                task: works[i].task,
                date: getDateString(date:works[i].date),
                time: timeString(time: works[i].time)))
        }
        return workString
    }
    
    func clearWorkList(){
        storage.save(workList: [])
    }
    
    
    // MARK: PARSERS
    func timeString(time: Int) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func getDateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd'-'MM'-'YYY'"
        return dateFormatter.string(from: date)
    }
}

