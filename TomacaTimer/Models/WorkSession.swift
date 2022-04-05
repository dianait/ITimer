import Foundation

// MARK: TIMER CONFIG
struct TimerConfig {
    let mainTime: Int = 25 * 60
    let shortBreakTime: Int = 5 * 60
    var longBreakTime: Int
    let completeSymbol: String = "✅"
    let incompleteSymbol: String = "❌"
    let cursorSymbol: String = "⏱"
    let workTitle: String = "👩‍💻 Trabajar"
    let BreakTitle: String = "☕️ Descanso"
}

class WorkSession {
    var counterMain: Int = 0
    var task: String = ""
    var totalTime: Int = 0
    var date: Date = Date.now
    var timerConfig: TimerConfig
    var currentStateTitle: String = "👩‍💻 Trabajar"
    var currentState = "work"
    var workList: [Work] = []
    var currentCursor: Int = 0
    var isTaskSave: Bool = false
    var progress: String = ""
    
    init() {
        let storage = StorageController()
        let currentLongBrake = storage.getLongBrake()
        self.progress = "25'⏱ 5' 25' 5' 25' 5' 25' \(currentLongBrake)'"
        let timer = TimerConfig(longBreakTime: currentLongBrake * 60)
        self.timerConfig = timer
    }
}

// MARK: WORKLIST
struct Work: Hashable, Encodable, Decodable {
    let task: String
    let date: Date
    var time: Int
}

struct WorkString: Hashable, Encodable, Decodable {
    let task: String
    let date: String
    var time: String
}

// MARK: NOTIFICATIONS
struct INotification {
    let title: String
    let subtitle: String
    let timeToWait: Double = 3.0
}

