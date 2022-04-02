import SwiftUI

struct Counter: View {
    @State var timer: Timer? = nil
    @State var seconds: Int = 0
    @State var minutes: Int
    var goTo: () -> Void
    var progress: String
    var task: String
    var currentState: String
    
    private func startTimer(){
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            if self.seconds == 0 {
                if self.minutes == 0 {
                    goTo()
                }
                self.seconds = 59
                self.minutes = self.minutes - 1
            } else {
                self.seconds = self.seconds - 1
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(self.progress).padding()
            Spacer()
            Text(self.currentState).font(.title)
            if self.currentState != "☕️ Descanso" {
                Text(self.task).font(.title2)
            }
            Text("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
                .fontWeight(.bold)
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .padding()
            HStack{
                Button("⏸"){}
                Button("⏹"){}
                Button("⏩"){}
            }.font(.largeTitle)
            Spacer()
                Image("logo")
                .resizable()
                .padding()
                .frame(width: 90, height: 90, alignment: .leading)
        }.onAppear{ startTimer() }
    }
}

struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        Counter(minutes: 30, goTo: { print("") }, progress: "25 5 25 5 25 5 25 15", task: "Refactor ChatList", currentState: "👩‍💻 A trabajar...")
    }
}
