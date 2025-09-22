//
//  RootView.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 22/09/2025.
//

import Foundation
import Core
import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        switch appState.root {
        case .login:
            AppDI.shared.makeLoginView()
                .environmentObject(appState)
            
        case .home:
            AppDI.shared.constructHomeView()
                .environmentObject(appState)

        }
    }
}
