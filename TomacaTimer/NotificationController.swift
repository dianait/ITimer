import Foundation
import UserNotifications

class Notification {
    let notifiactionToMain = INotification(title: "👩‍💻 Trabajar", subtitle: "")
    let notifiactionToShortBrake = INotification(title:"☕️ Descanso", subtitle: "")
    let notifiactionToLongBrake = INotification(title: "🏁 ¡Bien Hecho!", subtitle: "")
    var currentNotification: INotification
    
    
    init() {
        self.currentNotification = self.notifiactionToShortBrake
        self.askPermission()
    }
        
    private func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func create(noti: INotification){
        let content = UNMutableNotificationContent()
        content.title = noti.title
        content.subtitle = noti.subtitle
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: noti.timeToWait, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    private func getCurrent(currentState: String) -> INotification {
        switch currentState {
        case "work":
            return self.notifiactionToShortBrake
        case "longPause":
            return self.notifiactionToLongBrake
        case "shortPause":
            return self.notifiactionToMain
        default:
            return self.notifiactionToShortBrake
        
        }
    }
    
    func display(state: String){
        self.create(noti: self.getCurrent(currentState: state))
    }
}
