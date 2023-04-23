//
//  ContentView.swift
//  Derootifier
//
//  Created by Анохин Юрий on 15.04.2023.
//

import SwiftUI
import AuxiliaryExecute

struct ContentView: View {
    let scriptPath = Bundle.main.path(forResource: "repack-rootless", ofType: "sh")!
    @State private var showingSheet = false
    @State private var selectedFile: URL?
    @State private var outputAux = ""
    
    var body: some View {
        VStack {
            VStack {
                Button("Select .deb file") {
                    showingSheet = true
                }
                .buttonStyle(TintedButton(color: .white, fullwidth: true))
                
                if selectedFile?.description.isEmpty == true {
                    Button("Convert .deb") {
                        if let debURL = selectedFile {
                            outputAux = repackDeb(scriptPath: scriptPath, debURL: debURL)
                            UIApplication.shared.alert(title: "Converting...", body: outputAux, withButton: !outputAux.isEmpty)
                        }
                    }
                    .buttonStyle(TintedButton(color: .white, fullwidth: true))
                }
                
                Text("Derootifier by haxi0 with help of evelyn, inactive and Nightwind. Made with ♡")
                    .foregroundColor(.white.opacity(0.5))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12))
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GradientView())
        .ignoresSafeArea()
        .onAppear {
            UIApplication.shared.alert(title: "Warning", body: "Please make sure the following packages are installed: dpkg-deb, file, fakeroot, odcctools, ldid (from Procursus).")
#if !targetEnvironment(simulator)
            folderCheck()
#endif
        }
        .sheet(isPresented: $showingSheet) {
            DocumentPicker(selectedFile: $selectedFile)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
