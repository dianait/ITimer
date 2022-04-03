import SwiftUI

struct WorkListView: View {
    var viewModel: TimerViewModel
    
    var body: some View {
        VStack {
            ScrollView{
                ForEach(viewModel.workListString(), id: \.self) { work in
                    Text("\(work.task)")
                    Text("📅 \(work.date) ⏳ \(work.time)")
                }
            }
            ButtonView(text: "⏪ VOLVER", handle:  viewModel.initialize)
        }
    }
}

struct WorkListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkListView(viewModel: TimerViewModel())
    }
}
