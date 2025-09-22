# ``FeedFeature``

<!--@START_MENU_TOKEN@-->This is a Feed feature a list of feed returned by the provider you can integrate with , with a details view to display the article item.<!--@END_MENU_TOKEN@-->

## Overview

FeedFeature is a modular SwiftUI component designed to display a list of articles and their details within the PostsApp architecture. It encapsulates all feed-related UI, models, and presentation logic, enabling easy integration and reuse across different parts of the application or in other projects.

- FeedFeature includes:
    - `ArticleModel`: Defines the data structure for articles.
    - `FeedView`: The main view presenting the feed list.
    - `FeedViewModel`: Handles data fetching, state management, and business logic for the feed.
    - `ArticleView` and `FeedDetailsView`: UI components for displaying individual articles and detailed views.
    - `FirstAppear+Modifier`: A reusable SwiftUI modifier for handling first appearance events.

## Usage

To use `FeedFeature` in your SwiftUI application:

1. **Import the module:**
   ```swift
   import FeedFeature
   ```

2. **Create a data provider or use your own data source:**
   - You can use a default provider or implement your own conforming to the expected interface.

3. **Initialize the ViewModel:**
   ```swift
   let viewModel = FeedViewModel(provider: MyFeedProvider())
   ```

4. **Present the FeedView in your app:**
   ```swift
   FeedView(viewModel: viewModel)
   ```

5. **Navigation to details:**
   - `FeedView` handles navigation to `FeedDetailsView` for each article.

### Example

```swift
import SwiftUI
import FeedFeature

struct ContentView: View {
    private let viewModel = FeedViewModel(provider: MyFeedProvider())
    var body: some View {
        FeedView(viewModel: viewModel)
    }
}
```

### Reusability
- You can reuse `FeedView` and `FeedViewModel` in any SwiftUI app by providing a custom data provider.
- Extend or customize `ArticleView` and `FeedDetailsView` for your own article presentation needs.
- Use `FirstAppear+Modifier` for custom appearance logic in other views.
