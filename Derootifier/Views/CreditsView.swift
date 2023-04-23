//
//  CreditsView.swift
//  Derootifier
//
//  Created by Анохин Юрий on 23.04.2023.
//

import SwiftUI
import FluidGradient

struct CreditsView: View {
    var body: some View {
        NavigationView {
            ZStack(alignment: .center) {
                FluidGradient(blobs: [.green, .mint],
                              highlights: [.green, .mint],
                              speed: 0.5,
                              blur: 0.80)
                .background(.green)
                .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        creditView(imageURL: URL(string: "https://avatars.githubusercontent.com/u/85764897?v=4"), name: "haxi0", description: "Made the app")
                        creditView(imageURL: URL(string: "https://avatars.githubusercontent.com/u/70823629?v=4"), name: "evelyneee", description: "Helped a lot, gave the idea to make this app")
                        creditView(imageURL: URL(string: "https://avatars.githubusercontent.com/u/81449663?v=4"), name: "NightwindDev", description: "Tester, massive thanks")
                        creditView(imageURL: URL(string: "https://avatars.githubusercontent.com/u/80824905?v=4"), name: "korboybeats", description: "Tester, massive thanks")
                    }
                    .padding()
                }
                .padding()
                .listStyle(.insetGrouped)
            }
        }
    }
    
    private func creditView(imageURL: URL?, name: String, description: String) -> some View {
        HStack {
            AsyncImage(url: imageURL, content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 35, maxHeight: 35)
                    .cornerRadius(20)
            }, placeholder: {
                ProgressView()
                    .frame(maxWidth: 35, maxHeight: 35)
            })
            
            VStack(alignment: .leading) {
                Button(name) {
                    if let url = URL(string: "https://github.com/\(name)") {
                        UIApplication.shared.open(url)
                    }
                }
                .font(.headline.weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
                
                Text(description)
                    .font(.system(size: 13))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .foregroundColor(.white)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
