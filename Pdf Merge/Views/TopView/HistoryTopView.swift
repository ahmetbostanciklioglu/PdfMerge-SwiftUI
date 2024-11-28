import SwiftUI

struct HistoryTopView: View {
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color("secondarybgColor"))
                .frame(maxHeight: 134)
            
            Spacer()
            
            // Title: .pdf and Merge
            Text("History")
                .font(Font.custom("Abril", size: 38))
                .italic()
                .fontWeight(.semibold)
                .foregroundColor(Color("primarybgColor"))
                .padding()
            
            Spacer()
        }
    }
}
