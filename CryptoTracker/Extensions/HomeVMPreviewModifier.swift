//
//  HomeVMPreviewModifier.swift
//  CryptoTracker
//
//  Created by shakir Gamzaev on 8/11/24.
//

import Foundation
import SwiftUI


struct HomeVMPreviewModifier: PreviewModifier {
    static func makeSharedContext() async throws -> HomeViewModel {
        return HomeViewModel.previewHomeViewModel
    }
    func body(content: Content, context: HomeViewModel) -> some View {
        content
            .environment(context)
    }
}
