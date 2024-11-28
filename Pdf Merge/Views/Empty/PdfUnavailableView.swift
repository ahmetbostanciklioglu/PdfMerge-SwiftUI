import SwiftUI

struct PdfUnavailableView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Image("pdfIcon")
                .resizable()
                .frame(width: 109, height: 109)
            
            VStack {
                HStack {
                    Text("You don't have any")
                    
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("tertiarybgColor"))
                    +
                    Text(" PDF Documents")
                        .font(.title2)
                        .bold()
                        .foregroundColor(Color("primarybgColor"))
                }
                
                HStack {
                    Spacer()
                    
                    Image("lines")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 9)
                }
                .padding(.horizontal)
                .padding(.top,6)
            }
        }
        .offset(y: -60)
    }
}

