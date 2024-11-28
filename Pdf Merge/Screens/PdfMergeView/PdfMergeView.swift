import SwiftUI
import PDFKit
import UIKit
import SwiftData

struct PdfMergeView: View {
    
    @Query(sort: \Document.name, order: .forward) var mergedDocuments: [Document] = []
    @Environment(\.modelContext)  var context
    @ObservedObject var viewModel = PdfMergeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.selectedTab == .right {
                    HistoryTopView()
                } else {
                    PdfMergeTopView(
                        isDocumentPickerPresented: $viewModel.isDocumentPickerPresented,
                        isDocumentUploaded: $viewModel.isDocumentUploaded,
                        documents: $viewModel.documents
                    )
                }
                
                Spacer()
                
                if viewModel.selectedTab == .right {
                    if !mergedDocuments.isEmpty {
                        HistoryView(mergedDocuments: mergedDocuments)
                    } else {
                        Text("No merged PDF available.")
                            .foregroundStyle(.gray)
                    }
                } else if viewModel.selectedTab == .left {
                    if viewModel.documents.isEmpty {
                        PdfUnavailableView()
                    } else {
                        PdfListView(documents: $viewModel.documents)
                    }
                } else {
                    if viewModel.isProcessingMerge {
                        ProgressView("Merging PDFs...")
                            .padding()
                    } else if !viewModel.documents.isEmpty && viewModel.documents.count >= 2 {
                        PdfListView(documents: $viewModel.documents)
                            .onAppear {
                                viewModel.mergePDFs()
                            }
                    } else if !viewModel.documents.isEmpty && viewModel.documents.count == 1 {
                        Text("There is only one pdf to merge")
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                    } else {
                        Text("No documents to merge")
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                    }
                }
                
                Spacer()
                CustomTabBarView(selectedTab: $viewModel.selectedTab)
            }
            .background(Color(.appbg))
            .ignoresSafeArea()
        }
    }
}
