import SwiftUI

struct PdfMergeTopView: View {
    
    @Binding var isDocumentPickerPresented: Bool
    @Binding var isDocumentUploaded: Bool
    @Binding var documents: [Document]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color("primarybgColor"))
                .frame(maxHeight: 134)
            
            Spacer()
            HStack {
                // Title: .pdf and Merge
                Text(".pdf")
                    .font(Font.custom("Abril", size: 58))
                    .italic()
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                
                +
                Text("Merge")
                    .font(Font.custom("Inter", size: 30))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .kerning(1.1)
                
                Spacer()
                
                Button {
                    isDocumentPickerPresented = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(width: 55, height: 55)
                }
                .fullScreenCover(isPresented: $isDocumentPickerPresented) {
                    DocumentPicker { documentInfo in
                        documents.append(documentInfo)
                    }
                }
            }
            .padding()
        }
    }
}
