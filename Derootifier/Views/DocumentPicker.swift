//
//  DocumentPicker.swift
//  Derootifier
//
//  Created by Анохин Юрий on 15.04.2023.
//

import SwiftUI
import MobileCoreServices

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var selectedFile: URL?
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeItem)], in: .import)
        picker.allowsMultipleSelection = false
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPicker
        
        init(_ parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let selectedFileURL = urls.first else { return }
            let fileManager = FileManager.default
            
            guard fileManager.fileExists(atPath: selectedFileURL.path) else { return }
            
            let destFolderURL = URL(fileURLWithPath: "/var/jb/var/mobile/.Derootifier")
            
            do {
                try fileManager.createDirectory(at: destFolderURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
                return
            }
            
            let destFileURL = destFolderURL.appendingPathComponent(selectedFileURL.lastPathComponent)
            
            do {
                if fileManager.fileExists(atPath: destFileURL.path) {
                    try fileManager.removeItem(at: destFileURL)
                }
                
                try fileManager.copyItem(at: selectedFileURL, to: destFileURL)
                
                parent.selectedFile = destFileURL
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
