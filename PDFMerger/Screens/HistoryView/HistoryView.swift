import SwiftUI
import SwiftData



struct HistoryView: View {
    
    var mergedDocuments: [Document]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List{
            ForEach(mergedDocuments, id: \.self) { document in
                NavigationLink(destination: DetailView(document: document)) {
                    HStack {
                        HistoryPdfIconView()
                        
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
                    }
                    .padding(.vertical, 8)
                }
                .foregroundColor(.buttonbg)
                .listRowSeparator(.hidden)
                .listRowBackground(Color(.appbg))
            }
            .onDelete(perform: deleteItem)
            .navigationBarBackButtonHidden()
        }
        .background(Color(.appbg))
        .listStyle(PlainListStyle())
        .navigationBarBackButtonHidden()
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let document = mergedDocuments[index]
            context.delete(document)
        }
        
        try? context.save()
    }
}



struct HistoryPdfIconView: View {
    var body: some View {
        
        Image("miniPdfIcon")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24, alignment: .center)
            .padding(12)
            .background(Color("secondarybgColor"))
            .cornerRadius(10)
            .padding(.trailing, 10)
    }
}



#Preview {
    HistoryPdfIconView()
}


