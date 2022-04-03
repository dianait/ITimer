import SwiftUI

struct FinishView: View {
    var viewModel: TimerViewModel
    var workSession: WorkSession
    var dateString = ""
    var timeString = ""
    
    init(viewModel: TimerViewModel, workSession: WorkSession){
        self.viewModel = viewModel
        self.workSession = workSession
        self.dateString = viewModel.getDateString(date: self.workSession.date)
        self.timeString = viewModel.timeString(time: self.workSession.totalTime)
    }
    
    var body: some View {
        VStack{
            Text("📅 \(self.dateString)").fontWeight(.semibold)
                .font(.system(size: 20))
                .frame(maxWidth: .infinity)
            Text("⏳ \(self.timeString)").fontWeight(.semibold)
                .font(.system(size: 50))
                .frame(maxWidth: .infinity)
            WorkListView(viewModel: viewModel)
        }.background(Color("Secondary"))
    }
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(viewModel: TimerViewModel(), workSession: WorkSession())
    }
}
