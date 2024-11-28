import PDFKit

class PDFMerger {
    func merge(documents: [Document]) -> URL? {
        let pdfDocument = PDFDocument()
        
        for (_, document) in documents.enumerated() {
            guard let pdf = PDFDocument(url: document.url) else { continue }
            
            for pageIndex in 0..<pdf.pageCount {
                guard let page = pdf.page(at: pageIndex) else { continue }
                pdfDocument.insert(page, at: pdfDocument.pageCount)
            }
        }
        
        let tempDirectory = FileManager.default.temporaryDirectory
        let outputURL = tempDirectory.appendingPathComponent("merged.pdf")
        
        if pdfDocument.write(to: outputURL) {
            return outputURL
        } else {
            return nil
        }
    }
}
