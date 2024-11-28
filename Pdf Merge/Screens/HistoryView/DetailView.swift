import SwiftUI

struct DetailView: View {
    let document: Document
    @Environment(\.presentationMode) var presentationMode
    @State private var isShareSheetPresented = false
    
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
                ToolbarItem(placement: .cancellationAction) {
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
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        isShareSheetPresented = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                    }
                }
            }
            .background(.primarybg)
            .foregroundStyle(.white)
            .padding(.bottom)
            .sheet(isPresented: $isShareSheetPresented) {
                ShareSheet(items: [document.url])
            }
    }
}


