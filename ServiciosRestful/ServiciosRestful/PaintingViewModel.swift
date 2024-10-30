//
//  PaintingViewModel.swift
//  ServiciosRestful
//
//  Created by epismac on 29/10/24.
//


import SwiftUI

class PaintingViewModel: ObservableObject {
    @Published var paintings: [Painting] = []
    private let apiUrl = "https://127.0.0.1/api.php"  // URL del servidor HTTPS en XAMPP

    // se Configura una sesión URL con el delegate de seguridad
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: InsecureURLSessionDelegate(), delegateQueue: nil)
    }()

    func fetchPaintings(page: Int, limit: Int) {
        guard let url = URL(string: "\(apiUrl)?page=\(page)&limit=\(limit)") else { return }
        var request = URLRequest(url: url)
        request.addValue("Bearer your_api_key", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching paintings: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data returned")
                return
            }

            // Imprimir el JSON recibido para verificar su estructura
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            }

            do {
                let decodedResponse = try JSONDecoder().decode([Painting].self, from: data)
                DispatchQueue.main.async {
                    self.paintings = decodedResponse
                }
            } catch {
                print("Error decoding response: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
