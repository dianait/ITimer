import SwiftUI

struct TitleView: View {
    let title: String
    let task: String
    @Binding var timeRemaing: Int
    
    var body: some View {
        VStack {
            Text(title).font(.title).font(.largeTitle)
            Text(task).font(.title2).font(.title)
            Text("\(timeString(time: timeRemaing))")
                .fontWeight(.semibold)
                .frame(height: 80.0)
                .font(.system(size: 90))
                .frame(maxWidth: .infinity)
                .padding()
        }
    }
    
    private func timeString(time: Int) -> String {
           let minutes = Int(time) / 60 % 60
           let seconds = Int(time) % 60
           return String(format:"%02i:%02i", minutes, seconds)
       }
}
