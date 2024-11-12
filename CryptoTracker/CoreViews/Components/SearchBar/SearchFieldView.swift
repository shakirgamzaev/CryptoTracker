//
//  SearchFieldView.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 12/11/24.
//

import SwiftUI

struct SearchFieldView: View {
    @Binding var searchText: String
    @Environment(\.colorScheme) private var colorScheme
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("coinSearch", text: $searchText, prompt: Text("Search by name or symbol...").bold())
                .lineLimit(1)
                .autocorrectionDisabled(true)
                .keyboardType(.asciiCapable)
                .focused($isFocused)
            Image(systemName: "xmark.circle.fill")
                .font(.headline)
                .opacity(searchText.isEmpty ? 0 : 1)
                .onTapGesture {
                    searchText = ""
                    isFocused = false
                }
        }
        .padding()
        .background(.backgroundTheme)
        .clipShape(Capsule())
        .shadow(color: .accent.opacity(colorScheme == .dark ? 0.34 : 0.23), radius: 12)
    }
}

#Preview {
    @Previewable @State var searchText = ""
    SearchFieldView(searchText: $searchText)
        .padding(.horizontal)
}
