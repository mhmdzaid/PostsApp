//
//  ContentState.swift
//  Core
//
//  Created by Mohamed Elmalhey on 17/09/2025.
//

import Foundation

public enum ContentState: Equatable {
    case loading
    case loaded
    case error(String)
    case empty
}
