//
//  ContentView.swift
//  ServiciosRestful
//
//  Created by epismac on 29/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PaintingViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.paintings) { painting in
                VStack(alignment: .leading) {
                    Text(painting.paintingName ?? "Unknown Title")
                        .font(.headline)
                    Text("by \(painting.artistName ?? "Unknown Artist")")
                        .font(.subheadline)
                    Text("Adjusted Price: $\(painting.adjustedPrice ?? "0.00")")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Art Gallery")
            .onAppear {
                viewModel.fetchPaintings(page: 1, limit: 10)
            }
        }
    }
}
