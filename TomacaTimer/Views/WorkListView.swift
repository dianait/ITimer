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
            HStack {
                Button("⏪") {
                    viewModel.idle()
                }.font(.system(size: 40))
                Button("🚮") {
                    viewModel.clearWorkList()
                }.font(.system(size: 40))
                
            }
        }
    }
}

struct WorkListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkListView(viewModel: TimerViewModel())
    }
}
