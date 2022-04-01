import Foundation

struct TimerConfig {
    let mainTime: Int = 5
    let shortBreakTime: Int = 2
    var longBreakTime: Int = 3
}

struct WorkSession {
    var timerConfig: TimerConfig = TimerConfig()
    var counterMain: Int = 0
    var counterShort: Int = 0
    var counterLong: Int = 0
    var task: String = ""
    var totalTime: Int = 0
    var date: Date = Date.now
}
