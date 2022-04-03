import Foundation
import Combine
import SwiftUI

class TimerController {
    @State var timer: Timer.TimerPublisher = Timer.publish(every: 1, on: .main, in: .common)
    @State var connectedTimer: Cancellable? = nil
    @State var isPaused: Bool
    @State var timeRemaing: Int
    
    init(isPaused: Bool, timeRemaing: Int){
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.connectedTimer = nil
        self.isPaused = isPaused
        self.timeRemaing = timeRemaing
    }
        
    private func instantiateTimer() {
           self.isPaused = false
           self.timer = Timer.publish(every: 1, on: .main, in: .common)
           self.connectedTimer = self.timer.connect()
           return
       }
       
    private func cancelTimer() {
           self.isPaused = true
           self.connectedTimer?.cancel()
           return
       }
       
    private func resetCounter() {
           self.timeRemaing = 0
           return
       }
       
    private func restartTimer() {
           self.timeRemaing = 1 * 60
           self.cancelTimer()
           self.instantiateTimer()
           return
       }
    
    private func timeString(time: Int) -> String {
           let minutes = Int(time) / 60 % 60
           let seconds = Int(time) % 60
           return String(format:"%02i:%02i", minutes, seconds)
       }
}
