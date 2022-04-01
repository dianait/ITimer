import SwiftUI

struct Counter: View {
    var viewModel: TimerViewModel
    @State var timer: Timer? = nil
    @State var minutes: Int
    @State var seconds: Int = 59
    var goTo: () -> Void
    
    private func startTimer(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
         if self.seconds == 0 {
           self.seconds = 59
           self.minutes = self.minutes - 1
           } else {
           self.seconds = self.seconds - 1
         }
       }
     }
    
    var body: some View {
        VStack {
            Text("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
                .fontWeight(.semibold)
                .font(.title)
                .frame(maxWidth: .infinity)
                .padding()
        }.onAppear{ startTimer() }
        }
    }

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        Counter(viewModel: TimerViewModel(), minutes: 30, goTo: { print("") })
    }
}

/*
 .onReceive(self.timer) { _ in
     if self.minutes > 0 {
         self.minutes -= 1
     }
     else {
         goTo()
     }
 }
 */
