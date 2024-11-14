//
//  MeasureHeight.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 13/11/24.
//

import Foundation
import SwiftUI


struct MeasureHeight: ViewModifier {
    var size: Binding<CGSize>
    func body(content: Content) -> some View {
        content
            .onGeometryChange(for: CGSize.self) { geo in
                geo.size
            } action: { newValue in
                size.wrappedValue = newValue
            }

    }
}

extension View {
    func measureSize(size: Binding<CGSize>) -> some View {
        modifier(MeasureHeight(size: size))
    }
}
