import SwiftUI

struct ControllersView: View {
    @Binding var showToast: Bool
    @Binding var timeRemaing: Int
    var instantiateTimer: () -> Void
    var cancelTimer: () -> Void
    var goTo: () -> Void
    
    var body: some View {
        HStack{
            Button("▶️") { self.instantiateTimer() }
            Button("⏸") { self.cancelTimer() }
            Button("⏩") { self.goTo() }
        }.font(.system(size: 50))
    }
}


