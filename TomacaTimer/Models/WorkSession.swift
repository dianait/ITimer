import Foundation

struct TimerConfig {
    let mainTime: Int = 1
    let shortBreakTime: Int = 1
    var longBreakTime: Int = 1
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
    var progress: String = "25'⏱ 5' 25' 5' 25' 5' 25' 15'"
    var currentState: String = "👩‍💻 A trabajar..."
}
