# ``LoginFeature``

## Summary

LoginFeature is a modular SwiftUI component for user authentication. It encapsulates all login-related UI, state management, and networking logic, enabling easy integration and reuse across different parts of the application or in other projects.

> **Note:** The LoginFeature currently uses a coupled dummy service for authentication, intended for learning and demonstration purposes. The service used is [https://dummyjson.com/docs/auth#auth-login](https://dummyjson.com/docs/auth#auth-login). In a production scenario, this service can be separated or replaced with another from the integrating app to enable real authentication and improve testability.

---

## Overview

LoginFeature provides:
- **LoginView**: The main SwiftUI view presenting the login form and handling user interaction.
- **LoginViewModel**: An observable object managing the login state, credentials, and business logic.
- **LoginService**: Handles network requests for authentication using Alamofire.
- **LoginProvider**: Supplies dependencies (view model, images, callbacks) to the view.
- **LoginModel**: Data models for login requests and responses.

### Architecture

```
LoginFeature/
 ├── LoginView.swift         # Main login screen UI
 ├── LoginViewModel.swift    # Handles login logic and state
 ├── LoginService.swift      # Networking/auth logic
 ├── LoginProvider.swift     # Dependency provider
 ├── LoginModel.swift        # Data models (e.g., LoginResponse)
 └── LoginFeature.docc/      # Documentation
```

### Component Tree

```
LoginView
 └── LoginViewModel
      └── LoginService
```

---

## Usage

### 1. Import the Module

```swift
import LoginFeature
```

### 2. Create a Provider

```swift
let provider = LoginProvider(
    viewModel: LoginViewModel(LoginService(), onLoginSuccess: { user in
        // Handle login success (e.g., navigate to home)
    }),
    loginViewImage: Image("login_bg", bundle: .main)
)
```

### 3. Present the LoginView

```swift
LoginView(provider: provider)
    .environmentObject(appState) // Inject AppState for navigation
```

### 4. Handle Navigation

- On successful login, `LoginViewModel` sets `contentState` to `.loaded` and calls `onLoginSuccess`.
- The view observes `contentState` and updates the `AppState` environment object. Navigation is handled by the integrating app, which responds to changes in `AppState`.

---

## How It Works

- **UI**: `LoginView` displays username/password fields, a login button, and error/loading states.
- **State**: `LoginViewModel` manages credentials and login state (`contentState`).
- **Networking**: `LoginService` sends a POST request to the configured URL and decodes the response.
- **Error Handling**: Errors are surfaced via alerts in the UI.
- **Navigation**: On success, the app navigates to the home screen using `AppState`.

---

## Reusability

- You can reuse `LoginView` and `LoginViewModel` in any SwiftUI app by providing a custom service or provider.
- Swap out `LoginService` for custom authentication logic.
- Extend `LoginView` for additional fields or branding.
- Use dependency injection for testability.

---

## Example Integration in PostsApp

```swift
import LoginFeature

@main
struct PostsApp: App {
    @StateObject var appState = AppState()
    var body: some Scene {
        WindowGroup {
            LoginView(provider: provider)
                .environmentObject(appState)
        }
    }
}
```

---

## Topics

### Views
- `LoginView`: Main login screen UI.

### ViewModels
- `LoginViewModel`: Handles login logic and state.

### Services
- `LoginService`: Networking/auth logic.

### Models
- `LoginModel`, `LoginResponse`: Data models for login.

### Providers
- `LoginProvider`: Supplies dependencies to the view.

### Integration
- How to use in PostsApp.

### Error Handling
- `NetworkError`, alerts.

---

## Groups

- **Login UI**: Components for user input and feedback.
- **State Management**: ViewModel and state handling.
- **Networking**: Service layer for authentication.
- **Integration & Reuse**: Instructions and examples for using LoginFeature in other projects.
