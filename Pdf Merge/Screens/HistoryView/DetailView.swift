import SwiftUI

struct DetailView: View {
    let document: Document
    @Environment(\.presentationMode) var presentationMode
    
    init(document: Document) {
        self.document = document
        
    }
    var body: some View {
        PDFKitView(url: document.url)
            .navigationTitle("Pdf Merge")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationBarBackButtonHidden()
            .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss() // Ekranı kapat
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.white)
                                Text("Geri")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text(".pdf")
                                .font(Font.custom("Abril", size: 28))
                                .italic()
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                
                            +
                            Text("Merge")
                                .font(Font.custom("Inter", size: 17))
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .kerning(1.1)
                        }
                    }
            }
            .background(.primarybg)
            .foregroundStyle(.white)
            .padding(.bottom)
    }
    
    
}
