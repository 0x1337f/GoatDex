//
//  ContentView.swift
//  PokeTest
//
//  Created by 0x1337f on 01.04.24.
//

import SwiftUI

// ViewModel, das die Logik für das Fetching der Daten beinhaltet
class ViewModel: ObservableObject {
    @Published var jsonText = ""

    func fetchData() {
        guard let url = URL(string: "https://pokemon-go-api.github.io/pokemon-go-api/api/pokedex/id/1.json") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.jsonText = jsonString
                    }
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }.resume()
    }
}


struct ApiResponse: Codable {
    let value: String // Ändern Sie diesen Typ entsprechend der tatsächlichen Struktur Ihrer Daten.
}

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        ScrollView {
            Text(viewModel.jsonText)
                .padding()
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 100)
                .font(.system(.body, design: .monospaced))
        }
        .onAppear{
            viewModel.fetchData()
        }
    }
}

#Preview {
    ContentView()
}
