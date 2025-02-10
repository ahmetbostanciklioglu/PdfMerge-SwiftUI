import SwiftUI
import UIKit

struct ShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    var activities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> some UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: activities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
