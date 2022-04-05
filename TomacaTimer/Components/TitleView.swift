import SwiftUI

struct TitleView: View {
    let viewModel: TimerViewModel
    @Binding var timeRemaing: Int

    var body: some View {
        VStack {
                Text(self.viewModel.workSession.currentStateTitle)
                    .font(.title).font(.largeTitle).fontWeight(.semibold)
                Text("\(timeString(time: timeRemaing))")
                .fontWeight(.bold)
                .font(.system(size: 100))
                .frame(maxWidth: .infinity)
                .foregroundColor(Color("White"))
                .shadow(color: .black, radius: 1)
        }.frame(height: 180)
    }
    
    private func timeString(time: Int) -> String {
           let minutes = Int(time) / 60 % 60
           let seconds = Int(time) % 60
           return String(format:"%02i:%02i", minutes, seconds)
       }
}
