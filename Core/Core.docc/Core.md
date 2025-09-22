# ``Core``

## Summary

Core is the foundational module for PostsApp, providing shared models, global state management, error handling, and utilities. It enables feature modules to communicate, manage app-wide state, and handle common concerns in a consistent and reusable way.

---

## Overview

Core includes:
- **AppState**: An `ObservableObject` managing global navigation and app state, injected via `@EnvironmentObject`.
- **ContentState**: Enum representing loading, loaded, error, and empty states for UI and view models.
- **NetworkError**: Centralized error type for networking and service layers.
- **Utilities**: Shared helpers such as `ProgressIndicatorView` (loading spinner) and `Reachability` (network status checker).

### Architecture

```
Core/
 ├── AppState.swift         # Global app state management
 ├── ContentState.swift     # UI and view model state enum
 ├── NetworkError.swift     # Error type for networking
 ├── Utilities/
 │    ├── ProgressIndicatorView.swift
 │    └── Reachability.swift
 └── Core.docc/             # Documentation
```

### Component Tree

```
AppState
ContentState
NetworkError
Utilities/
 ├── ProgressIndicatorView
 └── Reachability
```

---

## Usage

### 1. Global State Management
- Inject `AppState` via `@EnvironmentObject` in your views for navigation and app-wide state.
- Example:
  ```swift
  @EnvironmentObject var appState: AppState
  ```

### 2. ViewModel State
- Use `ContentState` in view models to represent loading, loaded, error, and empty states.
- Example:
  ```swift
  @Published var contentState: ContentState = .empty
  ```

### 3. Error Handling
- Use `NetworkError` for consistent error reporting in services and view models.
- Example:
  ```swift
  completion(.failure(.error("Something went wrong")))
  ```

### 4. Utilities
- Use `ProgressIndicatorView` for loading spinners in your UI.
- Use `Reachability` to check network status before making requests.

---

## Integration

- All feature modules (FeedFeature, LoginFeature, ProfileFeature) import Core for shared state, error handling, and utilities.
- App-wide navigation and state changes are managed via `AppState`.
- Consistent UI state and error handling are achieved using `ContentState` and `NetworkError`.

---

## Topics

### State Management
- `AppState`: Global navigation and state.
- `ContentState`: UI and view model state.

### Error Handling
- `NetworkError`: Centralized error type.

### Utilities
- `ProgressIndicatorView`: Loading spinner.
- `Reachability`: Network status checker.

---

## Groups

- **Global State**: AppState, ContentState
- **Error Handling**: NetworkError
- **Utilities**: ProgressIndicatorView, Reachability
- **Integration**: How feature modules use Core
