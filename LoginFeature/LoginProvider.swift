//
//  LoginProvider.swift
//  LoginFeature
//
//  Created by Mohamed Elmalhey on 20/09/2025.
//

import Foundation
import SwiftUICore

public struct LoginProvider {
    public init(viewModel: LoginViewModel,
                loginViewImage: Image) {
        self.viewModel = viewModel
        self.loginViewImage = loginViewImage
    }
    let viewModel: LoginViewModel
    let loginViewImage: Image
}
