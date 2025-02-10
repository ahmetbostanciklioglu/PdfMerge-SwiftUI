import SwiftUI


struct PdfListView: View {
    
    @Binding var documents: [Document]
    
    var body: some View {
        List{
            ForEach(documents, id: \.self) { document in
                HStack {
                    // Move Icon
                    VStack {
                        Image(systemName: "mount.fill")
                        
                        
                    }
                    .foregroundColor(.black)
                    .padding(.trailing, 10)
                    
                    // Document Info
                    VStack(alignment: .leading, spacing: 4) {
                        Text(document.name)
                            .font(.headline)
                            .foregroundColor(.black)
                            .lineLimit(2)
                        Text("\(document.pages) Page\(document.pages > 1 ? "s" : "")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // Options Icon
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(90))
                }
                .padding(.vertical, 8)
                .listRowSeparator(.hidden)
                .listRowBackground(Color(.appbg))
            }
            .onDelete(perform: deleteItem)
            
        }
        .background(Color(.appbg))
        .listStyle(PlainListStyle())
        
    }
    
    func deleteItem(at offsets: IndexSet) {
        documents.remove(atOffsets: offsets)
    }
}
