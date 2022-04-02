import Foundation

struct TimerConfig {
    let mainTime: Int = 1
    let shortBreakTime: Int = 1
    var longBreakTime: Int = 1
}

struct WorkSession {
    var timerConfig: TimerConfig = TimerConfig()
    var counterMain: Int = 0
    var task: String = "Refactor ChatList Example"
    var totalTime: Int = 0
    var date: Date = Date.now
    var complete: String = "✅"
    var incomplete: String = "❌"
    var progress: String = "25 5 25 5 25 5 25 15"
}
