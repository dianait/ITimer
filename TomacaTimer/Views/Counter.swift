import SwiftUI

struct Counter: View {
    var viewModel: TimerViewModel
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining: Int
    var goTo: () -> Void
    
    var body: some View {
        Text("\(timeRemaining)")
            .fontWeight(.semibold)
            .font(.title)
            .onReceive(self.timer) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
                else {
                    goTo()
                }
            }.frame(maxWidth: .infinity)
            .padding()
        }
    }

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        Counter(viewModel: TimerViewModel(), timeRemaining: 30, goTo: { print("") })
    }
}
