import SwiftData
import Foundation

@Model
class Document: Identifiable, Hashable {
    @Attribute(.unique) var id = UUID()
    var name: String
    var pages: Int
    var url: URL
    
    init(name: String, pages: Int, url: URL) {
        self.name = name
        self.pages = pages
        self.url = url
    }
}


struct MockData {
    static let documents: [Document] = [
        Document(name: "Documents.pdf", pages: 1, url: URL(fileURLWithPath: "/path/to/sample1.pdf")),
        Document(name: "1-Documents.pdf", pages: 1, url: URL(fileURLWithPath: "/path/to/sample2.pdf")),
        Document(name: "2-Documents.pdf", pages: 3, url: URL(fileURLWithPath: "/path/to/sample3.pdf")),
        Document(name: "3-Documents.pdf", pages: 2, url:URL(fileURLWithPath: "/path/to/sample4.pdf")),
        Document(name: "4-Documents.pdf", pages: 12,url: URL(fileURLWithPath: "/path/to/sample5.pdf")),
        Document(name: "5-Documents.pdf", pages: 2,url: URL(fileURLWithPath: "/path/to/sample6.pdf")),
        Document(name: "6-Documents.pdf", pages: 5,url: URL(fileURLWithPath: "/path/to/sample7.pdf"))
    ]
}
