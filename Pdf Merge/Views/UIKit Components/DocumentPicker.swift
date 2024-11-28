import UIKit
import SwiftUI
import PDFKit

struct DocumentPicker: UIViewControllerRepresentable {
    
    var onDocumentPicked: (Document) -> Void
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onDocumentPicked: onDocumentPicked)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var onDocumentPicked: (Document) -> Void
        
        init(onDocumentPicked: @escaping (Document) -> Void) {
            self.onDocumentPicked = onDocumentPicked
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return  }
            
            if let pdfDocument = PDFDocument(url: url) {
                let pageCount = pdfDocument.pageCount
                let name = url.lastPathComponent
                let documentInfo = Document(name: name, pages: pageCount, url: url)
                onDocumentPicked(documentInfo)
            }
        }
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("Document picker was cancelled")
        }
    }
}
