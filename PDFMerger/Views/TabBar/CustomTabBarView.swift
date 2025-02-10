import SwiftUI

enum Tab {
    case left
    case center
    case right
}

struct CustomTabBarView: View {
    @Binding var selectedTab : Tab
    
    var body: some View {
        
        HStack {
            Button(action: {
                selectedTab = .left
            }) {
                Image(systemName: "square.grid.2x2.fill")
                    .font(.title2)
                    .foregroundColor(selectedTab == .left ? Color(.buttonbg) : .gray)
                    .frame(width: 24, height: 24)
            }
            
            Spacer()
            
            Button(action: {
                selectedTab = .center
            }) {
                ZStack {
                    Circle()
                        .fill(Color.red.opacity(0.2))
                        .frame(width: 60, height: 60)
                    
                    Circle()
                        .fill(Color(.buttonbg))
                        .frame(width: 55, height: 55)
                    
                    Image(systemName: "arrow.trianglehead.merge")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 22, height: 22)
                }
            }
            
            Spacer()
            
            Button(action: {
                selectedTab = .right
            }) {
                Image(selectedTab == .right ?  "historyIconSelected" : "historyIcon")
                    .font(.title2)
                    .foregroundColor(selectedTab == .right ? Color(.buttonbg) : .gray)
                    .frame(width: 24, height: 24)
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 30)
        .padding(.bottom)
        .background(Color.white)
        
    }
}



