import SwiftUI

struct Counter: View {
    @State var timer: Timer? = nil
    @State var minutes: Int
    @State var seconds: Int = 0
    var goTo: () -> Void
    var task: String
    var progress: String
    
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
            Text(self.task).font(.title2)
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
        Counter(minutes: 30, goTo: { print("") }, task: "Refactor ChatList", progress: "25 5 25 5 25 5 25 15")
    }
}
