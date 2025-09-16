//
//  OnFirstAppear+Modifier.swift
//  FeedFeature
//
//  Created by Mohamed Elmalhey on 16/09/2025.
//

import Foundation
import SwiftUICore

struct FirstAppear: ViewModifier {
    let action: () -> ();
    @State private var hasAppeared = false

    func body(content: Content) -> some View {
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action();
        }
    }
}

public extension View {
    func onFirstAppear(_ action: @escaping()->()) -> some View {
        modifier(FirstAppear(action: action))
    }
}
