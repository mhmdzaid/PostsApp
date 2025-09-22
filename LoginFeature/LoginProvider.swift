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
                loginViewImage: Image,
                onSuccessfullLogin: @escaping (LoginResponse) -> Void) {
        self.viewModel = viewModel
        self.loginViewImage = loginViewImage
        self.onSuccessfullLogin = onSuccessfullLogin
    }
    let viewModel: LoginViewModel
    let loginViewImage: Image
    let onSuccessfullLogin: ((LoginResponse) -> Void)
}
