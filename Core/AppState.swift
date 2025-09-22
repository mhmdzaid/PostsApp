//
//  AppState.swift
//  PostsApp
//
//  Created by Mohamed Elmalhey on 22/09/2025.
//

import Foundation
import Combine

public class AppState: ObservableObject {
    @Published public var root: Root
    
    public init(root: Root) {
        self.root = root
    }
}

public enum Root {
    case login
    case home
}
