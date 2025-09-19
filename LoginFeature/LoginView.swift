//
//  LoginView.swift
//  LoginFeature
//
//  Created by Mohamed Elmalhey on 17/09/2025.
//

import SwiftUI
import Core

public struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @State var showAlert = false
    @State private var navigationPath = NavigationPath()
    @State private var isLoggedInSuccessfully = false
    var router: LoginRouter
    private var errorMessage: String? {
        if case .error(let message) = viewModel.contentState {
            return message
        }
        return nil
    }
    
    public init(viewModel: LoginViewModel, router: LoginRouter = DefaultLoginRouter()) {
        self.viewModel = viewModel
        self.router = router
    }
    
    public var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack{
                VStack(alignment: .center) {
                    Text("Please Enter your credentials")
                        .font(.headline)
                    
                    TextField("Username", text: $viewModel.username)
                        .padding(20)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.cyan, lineWidth: 2)
                        )
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding(20)
                        .frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.cyan, lineWidth: 2)
                        )
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Login")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(20)
                    .background(.cyan)
                    .background(in: RoundedRectangle(cornerRadius: 15))
                    
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
                if viewModel.contentState == .loading {
                    ProgressIndicatorView()
                }
            }.navigationDestination(isPresented: $isLoggedInSuccessfully, destination: {
                router.navigateToOnSuccess()
            })
        }
        .navigationBarHidden(true)
        .onChange(of: viewModel.contentState) {
            if case .error = viewModel.contentState {
                showAlert = true
            }
            
            if viewModel.contentState == .loaded {
                isLoggedInSuccessfully = true
                print("logged in successfully ....")
            }
            
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Login Error"),
                message: Text(errorMessage ?? "Unknown error"),
                dismissButton: .default(Text("OK")) {
                    showAlert = false
                }
            )
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel.init(LoginService()))
}
