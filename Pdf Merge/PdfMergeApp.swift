import SwiftUI
import SwiftData

@main
struct PdfMergeApp: App {
    var body: some Scene {
        WindowGroup {
            PdfMergeView()
                .modelContainer(for: [Document.self])
        }
    }
}
