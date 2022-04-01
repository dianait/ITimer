import Foundation

struct TimerConfig {
    let mainTime: Int = 1
    let shortBreakTime: Int = 1
    var longBreakTime: Int = 1
}

struct WorkSession {
    var timerConfig: TimerConfig = TimerConfig()
    var counterMain: Int = 0
    var task: String = "Refactor ChatList"
    var totalTime: Int = 0
    var date: Date = Date.now
}
