import SwiftUI
import PDFKit
import UIKit
import SwiftData

struct PdfMergeView: View {
    
    @State var mergeList = true
    @State private var isDocumentPickerPresented = false
    @State private var isDocumentUploaded = false
    @State private var documents: [Document] = []
    
    @State private var selectedTab : Tab = .left
    @State private var mergedPdfURL: URL?
    @State private var isProcessingMerge = false
    
    @Query(sort: \Document.name, order: .forward) var mergedDocuments: [Document] = []
    @Environment(\.modelContext) private var context
    
    
    var body: some View {
        NavigationStack {
            
            VStack {
                if selectedTab == .right {
                    HistoryTopView()
                } else {
                    PdfMergeTopView(isDocumentPickerPresented: $isDocumentPickerPresented, isDocumentUploaded: $isDocumentUploaded, documents: $documents)
                }
                Spacer()
                
                if selectedTab == .right {
                    if !mergedDocuments.isEmpty {
                        HistoryView(mergedDocuments: mergedDocuments)
                        
                    } else {
                        Text("No merged PDF available.")
                            .foregroundStyle(.gray)
                    }
                } else if selectedTab == .left {
                    if documents.isEmpty  {
                        PdfUnavailableView()
                    } else {
                        PdfListView(documents: $documents)
                        
                    }
                } else {
                    if isProcessingMerge {
                        ProgressView("Merging PDFs...")
                            .padding()
                    } else if !documents.isEmpty && documents.count >= 2{
                        PdfListView(documents: $documents)
                            .onAppear {
                                mergePDFs()
                                
                            }
                    } else if !documents.isEmpty && documents.count == 1 {
                        Text("There is only one pdf to merge")
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                    }
                    
                    else {
                        Text("No documents to merge")
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                    }
                }
                
                Spacer()
                
                CustomTabBarView(selectedTab: $selectedTab)
            }
            .background(Color(.appbg))
            .ignoresSafeArea()
        }
    }
    
    func mergePDFs() {
        isProcessingMerge = true
        
        DispatchQueue.global().async {
            let pdfMerger = PDFMerger()
            if let mergedPdfURL = pdfMerger.merge(documents: documents) {
                
                let mergedDocument = Document(name: "MergedFile.pdf",
                                              pages: calculatePageCount(from: mergedPdfURL),
                                              url: mergedPdfURL)
                
                DispatchQueue.main.async {
                    context.insert(mergedDocument)
                    try? context.save()
                    
                    self.isProcessingMerge = false
                    self.selectedTab = .right
                }
            } else {
                DispatchQueue.main.async {
                    self.isProcessingMerge = false
                    print("PDF merge failed.")
                }
            }
        }
    }
    
    func calculatePageCount(from url: URL) -> Int {
        guard let pdfDocument = PDFDocument(url: url) else { return 0 }
        return pdfDocument.pageCount
    }
}

#Preview {
    PdfMergeView(mergeList: true)
    
}






















