import Foundation

// MARK: TIMER CONFIG
struct TimerConfig {
    let mainTime: Int = 1 * 60
    let shortBreakTime: Int = 1 * 60
    var longBreakTime: Int = 1 * 60
    let completeSymbol: String = "✅"
    let incompleteSymbol: String = "❌"
    let cursorSymbol: String = "⏱"
    let workTitle: String = "👩‍💻 Trabajar"
    let BreakTitle: String = "☕️ Descanso"
}

struct WorkSession {
    var timerConfig: TimerConfig = TimerConfig()
    var counterMain: Int = 0
    var task: String = "📚 Jinkobot"
    var totalTime: Int = 0
    var date: Date = Date.now
    var progress: String = "25'⏱ 5' 25' 5' 25' 5' 25' 15'"
    var currentStateTitle: String = "👩‍💻 Trabajar"
    var currentState = "work"
    var workList: [Work] = []
    var currentCursor: Int = 0
    var isTaskSave: Bool = false
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

