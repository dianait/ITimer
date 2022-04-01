import SwiftUI

struct Counter: View {
    var viewModel: TimerViewModel
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var minutes: Int
    @State var seconds: Int = 60
    var goTo: () -> Void
    
    var body: some View {
        VStack {
            Text("\(String(format: "%02d", minutes)):\(seconds)")
                .fontWeight(.semibold)
                .font(.title)
                .onReceive(self.timer) { _ in
                    if self.minutes > 0 {
                        self.minutes -= 1
                    }
                    else {
                        goTo()
                    }
                }.frame(maxWidth: .infinity)
                .padding()
            }
        }
    }

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        Counter(viewModel: TimerViewModel(), minutes: 30, goTo: { print("") })
    }
}
