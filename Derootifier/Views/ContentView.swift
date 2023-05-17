//
//  ContentView.swift
//  Derootifier
//
//  Created by Анохин Юрий on 15.04.2023.
//

import SwiftUI
import FluidGradient

struct ContentView: View {
    let scriptPath = Bundle.main.path(forResource: "repack-rootless", ofType: "sh")!
    @AppStorage("firstLaunch") private var firstLaunch = true
    @State private var showingSheet = false
    @State private var selectedFile: URL?
    @State private var outputAux = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Button("Select .deb file") {
                    showingSheet.toggle()
                }
                .buttonStyle(TintedButton(color: .white, fullwidth: true))
                
                if let selectedFile = selectedFile {
                    Button("Convert .deb") {
                        outputAux = repackDeb(scriptPath: scriptPath, debURL: selectedFile)
                        UIApplication.shared.alert(title: "Converting...", body: outputAux, withButton: !outputAux.isEmpty)
                    }
                    .buttonStyle(TintedButton(color: .white, fullwidth: true))
                }
                
                NavigationLink(
                    destination: CreditsView(),
                    label: {
                        HStack {
                            Text("Credits")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white.opacity(0.5))
                        .font(.system(size: 15))
                    }
                )
                .padding()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background (
                FluidGradient(blobs: [.green, .mint],
                              highlights: [.green, .mint],
                              speed: 0.5,
                              blur: 0.80)
                .background(.green)
            )
            .ignoresSafeArea()
            .onAppear {
                if firstLaunch {
                    UIApplication.shared.alert(title: "Warning", body: "Please make sure the following packages are installed: dpkg, file, fakeroot, odcctools, ldid (from Procursus).")
                    firstLaunch = false
                }
#if !targetEnvironment(simulator)
                folderCheck()
#endif
            }
            .sheet(isPresented: $showingSheet) {
                DocumentPicker(selectedFile: $selectedFile)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
