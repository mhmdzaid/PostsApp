//
//  LoginRouter.swift
//  LoginFeature
//
//  Created by Mohamed Elmalhey on 19/09/2025.
//

import Foundation
import SwiftUI

public protocol LoginRouter {
    func navigateToOnSuccess() -> AnyView
}

public struct DefaultLoginRouter: LoginRouter {
    public init() {}
    public func navigateToOnSuccess() -> AnyView {
        AnyView(Text("Logged In Successfully from default router!"))
    }
}
