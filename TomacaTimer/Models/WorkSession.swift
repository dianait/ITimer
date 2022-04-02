import Foundation

struct TimerConfig {
    let mainTime: Int = 1 * 60
    let shortBreakTime: Int = 1 * 60
    var longBreakTime: Int = 1 * 60
    let completeSymbol: String = "✅"
    let incompleteSymbol: String = "❌"
    let cursorSymbol: String = "⏱"
}

struct WorkSession {
    var timerConfig: TimerConfig = TimerConfig()
    var counterMain: Int = 0
    var task: String = "Refactor ChatList Example"
    var totalTime: Int = 0
    var date: Date = Date.now
    let progressInit: String = "25'⏱ 5' 25' 5' 25' 5' 25' 15'"
    var progress: String = "25'⏱ 5' 25' 5' 25' 5' 25' 15'"
    var currentStateTitle: String = "👩‍💻 A trabajar..."
    var currentState = "work"
    var workList: [Work] = []
    var currentCursor: Int = 0
}
