import SwiftUI
import SwiftData

@main
struct PDFMergerApp: App {
    var body: some Scene {
        WindowGroup {
            PdfMergeView()
                .modelContainer(for: [Document.self])
        }
    }
}
