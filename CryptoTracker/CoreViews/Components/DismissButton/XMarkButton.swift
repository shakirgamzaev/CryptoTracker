//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 15/11/24.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.title3)
        }
    }
}

#Preview {
    XMarkButton()
}
