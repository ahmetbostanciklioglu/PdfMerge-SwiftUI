import SwiftUI
import Combine
import PDFKit
import SwiftData

class PdfMergeViewModel: ObservableObject {
    @Published var mergeList = true
    @Published var isDocumentPickerPresented = false
    @Published var isDocumentUploaded = false
    @Published var documents: [Document] = []
    @Published var selectedTab: Tab = .left
    @Published var mergedPdfURL: URL?
    @Published var isProcessingMerge = false
    
    
    func mergePDFs() {
        isProcessingMerge = true
        
        DispatchQueue.global().async {
            do {
                let container = try ModelContainer(for: Document.self)
                let context = ModelContext(container)
                let pdfMerger = PDFMerger()
                if let mergedPdfURL = pdfMerger.merge(documents: self.documents) {
                    let mergedDocument = Document(name: "MergedFile.pdf",
                                                  pages: self.calculatePageCount(from: mergedPdfURL),
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
            } catch {
                DispatchQueue.main.async {
                    self.isProcessingMerge = false
                    print("Error initializing container or context: \(error)")
                }
            }
        }
    }
    
    func calculatePageCount(from url: URL) -> Int {
        guard let pdfDocument = PDFDocument(url: url) else { return 0 }
        return pdfDocument.pageCount
    }
}
