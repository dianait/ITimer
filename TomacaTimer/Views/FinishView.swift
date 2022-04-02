import SwiftUI

struct FinishView: View {
    var date: String
    var totalTime: String
    var body: some View {
        VStack{
            Text("📅 \(date)").fontWeight(.semibold)
                .font(.system(size: 20))
                .frame(height: 30.0)
                .frame(maxWidth: .infinity)
                .padding()
            Text("⏳ \(totalTime)").fontWeight(.semibold)
                .font(.system(size: 50))
                .frame(height: 80.0)
                .frame(maxWidth: .infinity)
        }
    }
}

struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView(date: "23/03/2022", totalTime: "34:23")
    }
}
