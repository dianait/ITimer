import Foundation

struct TimerConfig {
    let mainTime: Int = 25 * 60
    let shortBreakTime: Int = 5 * 60
    var longBreakTime: Int = 15 * 60
    let completeSymbol: String = "✅"
    let incompleteSymbol: String = "❌"
    let cursorSymbol: String = "⏱"
    let workTitle: String = "👩‍💻 Trabajar"
    let BreakTitle: String = "☕️ Descanso"
}

struct WorkSession {
    var timerConfig: TimerConfig = TimerConfig()
    var counterMain: Int = 0
    var task: String = "Refactor ChatList Example"
    var totalTime: Int = 0
    var date: Date = Date.now
    var progress: String = "25'⏱ 5' 25' 5' 25' 5' 25' 15'"
    var currentStateTitle: String = ""
    var currentState = "work"
    var workList: [Work] = []
    var currentCursor: Int = 0
}
