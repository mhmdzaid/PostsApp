//
//  ProgressView.swift
//  Core
//
//  Created by Mohamed Elmalhey on 17/09/2025.
//

import Foundation
import SwiftUI

public struct ProgressIndicatorView: View {
    public init() {}
    public var body: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .frame(width: 100, height: 100)
            .background(Color(.systemBackground).opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 5)
            .transition(.opacity)
    }
}
