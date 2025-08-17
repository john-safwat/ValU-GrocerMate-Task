# GrocerMate - Flutter Take-Home Task

## 📝 Project Overview

GrocerMate is a Flutter-based mobile application designed to simulate a grocery shopping experience. It allows users to browse products, search for specific items, manage a shopping cart, and handle a checkout process. The app is built with a strong emphasis on clean architecture, robust state management, and a seamless offline-first experience. This project was developed as a take-home task to demonstrate proficiency in Flutter, architectural patterns, and creating a resilient, user-friendly mobile application.

## ✨ Features

The application implements the following core user stories:

* **US1 - Product Discovery:**
    * View a list of product categories.
    * Browse a paginated list of products within each category.
    * Products display key information like price, stock status, and promotional badges (e.g., "deal", "fresh").
* **US2 - Advanced Search:**
    * Search for products by name with a debounced input to prevent excessive API calls.
    * Filter search results by category and brand for a more refined search experience.
* **US3 - Product Details:**
    * View a dedicated screen for each product with detailed information, including multiple images, a full description, nutritional facts, and allergens.
* **US4 - Shopping Cart:**
    * Add, remove, and update the quantity of items in the shopping cart.
    * The cart displays a running total, including subtotal, discounts, taxes, and delivery fees.
* **US5 - Save for Later:**
    * Move items from the cart to a "Saved for Later" list.
    * Easily move saved items back into the cart.
    * Both the cart and the saved list persist across application sessions.
* **US6 - Smart Checkout:**
    * Initiate a purchase from the cart.
    * Before completing the purchase, the app re-validates the price and stock of each item.
    * If any changes are detected (e.g., price change, out of stock), a bottom sheet appears, allowing the user to accept the new price, remove the item, or adjust the quantity before re-submitting.
* **US7 - Offline Mode:**
    * The app gracefully handles loss of internet connectivity.
    * Users can browse the last cached version of the product catalog.
    * Full offline management of the shopping cart and "Saved for Later" list is supported.
    * A clear banner indicates when the user is in offline mode.
* **US8 - UI Resilience:**
    * The app displays distinct and user-friendly UI for loading, empty, and error states.
    * Provides clear messaging and a "retry" option for failed network requests.
* **Theming:**
    * Supports both **Light and Dark themes**, automatically adapting to the system's theme settings.

## 🏗️ Architectural Deep Dive

The application is built using **Clean Architecture** principles to ensure a clear separation of concerns, making the codebase scalable, maintainable, and testable. This is complemented by a feature-first project structure and a robust set of core utilities.

### Core Principles

* **Dependency Rule:** The core principle is that inner layers (Domain) should not know anything about outer layers (Data, Presentation). Communication happens through abstractions (interfaces).
* **Dependency Injection:** The `get_it` service locator is used for dependency injection. It initializes and provides instances of BLoCs, Use Cases, Repositories, and Data Sources throughout the app, decoupling concrete implementations from their usage. The setup is configured in `core/di/di.dart`.

### Layer Breakdown

1. **Presentation Layer:** This layer is responsible for everything the user sees and interacts with.
    * **State Management:** The **BLoC (Business Logic Component)** pattern is used to manage UI state.
        * **Events:** UI actions (e.g., button clicks, text input) are dispatched as `Events` to the BLoC.
        * **BLoCs:** The BLoC receives `Events`, executes the relevant `Use Case` from the Domain layer, and based on the result (`Success` or `Failure`), emits a new `State`.
        * **States:** These are immutable objects that represent the state of the UI at a given time (e.g., `Loading`, `Loaded`, `Error`). The UI widgets listen to the BLoC's state stream and rebuild themselves in response to new states.
    * **UI (Screens/Widgets):** The UI is composed of Flutter widgets that are kept simple. They are responsible for rendering the state and dispatching events to the BLoCs.

2. **Domain Layer:** This is the heart of the application, containing the core business logic. It is completely independent of Flutter and any specific database or network implementation.
    * **Entities:** These are the core business objects (e.g., `Product`, `Category`). They are plain Dart objects with no external dependencies.
    * **Repositories (Abstract):** These are interfaces that define the contract for data operations (e.g., `ProductsRepository`). They dictate *what* the application can do with data, but not *how*.
    * **Use Cases (Interactors):** Each use case represents a single business operation (e.g., `GetProductsUseCase`). It orchestrates the flow of data by calling one or more repository methods and contains the specific business logic for that task.

3. **Data Layer:** This layer is responsible for all data retrieval and storage. It implements the repository contracts defined in the Domain layer.
    * **Repositories (Implementation):** These concrete classes implement the repository interfaces. Their primary role is to coordinate data from various data sources. For example, `ProductsRepositoryImpl` will first check for network connectivity. If online, it fetches data from the remote source, caches it locally, and then returns it. If offline, it returns the cached data directly from the local source.
    * **Data Sources:**
        * **Remote:** Handles all communication with the network, fetching data from the mock JSON endpoints. It uses a `safe_api_call` utility to handle network errors gracefully.
        * **Local:** Manages the local database using **Isar DB**. It's responsible for caching, retrieving, and updating data for offline use.
    * **Models/DTOs:** These are data structures that map directly to the remote API responses (DTOs) or local database tables (`local_product.dart`). Mappers are used to convert these models into Domain `Entities` before they are passed to the upper layers.

## ⚙️ Functionality Deep Dive

### Offline-First Strategy

The app's offline capability is centered in the `Data` layer.

1. **Connectivity Check:** The `NetworkInfo` utility (`core/network_utils`) checks the device's connectivity status.
2. **Repository Logic:** Before any data fetch, the repository implementation (e.g., `ProductsRepositoryImpl`) uses `NetworkInfo`.
    * **Online:** It calls the `RemoteDataSource`, which fetches fresh data. Upon success, the data is mapped to `LocalProduct` models and saved to the `LocalDataSource` (Isar), effectively updating the cache. The data is then mapped to domain `Entities` and returned to the BLoC.
    * **Offline:** It directly calls the `LocalDataSource` to retrieve the last cached data, maps it to `Entities`, and returns it.
3. **UI Feedback:** A banner is shown to the user to clearly indicate when they are operating in offline mode. Cart and saved list modifications are always performed on the local database, ensuring they are available offline.

### Smart Checkout Process

The checkout flow demonstrates the robust error handling and state management of the app.

1. **Initiation:** The user clicks "Purchase" in the `CartScreen`. This dispatches a `CheckoutEvent` to the `CartBloc`.
2. **Use Case Execution:** The `CartBloc` calls the `CheckoutUseCase`, passing the cart items.
3. **API Call:** The use case calls the `checkoutRepository.purchase()`, which in turn calls the `CheckoutRemoteDataSource` to make the POST request. The request includes the `expectedPrice` for each item.
4. **Response Handling:** The remote data source and repository handle various API responses:
    * **Success:** A `PurchaseResponse` entity with `status: success` is returned. The `CartBloc` emits a `CheckoutSuccessState`, and the UI navigates to an order confirmation screen.
    * **Price Change / Out of Stock:** The API returns a specific status (`price_changed`, `out_of_stock`). The `PurchaseResponseMapper` converts this into a `PurchaseResponse` entity with the appropriate status and a list of changed items.
5. **UI Reaction:** The `CartBloc` receives this entity and emits a `CheckoutReviewRequiredState` containing the details of the changes. The `CartScreen` listens for this state and presents a bottom sheet, allowing the user to review the changes and decide whether to accept them, remove items, and re-submit the purchase.

## 📁 Project Structure

The `/lib` directory is organized using a feature-first approach within the Clean Architecture layers. This structure enhances modularity and makes it easy to locate code related to a specific feature.

```
lib/
├── core/                       # Shared application-wide logic and utilities
│   ├── base/                   # Base classes for UI and ViewModels
│   ├── constants/              # Application constants
│   ├── di/                     # Dependency injection setup (using get_it)
│   ├── l10n/                   # Localization and internationalization
│   ├── network_utils/          # Network connectivity, error handling, safe API calls
│   ├── provider/               # App-wide configuration providers
│   ├── routing/                # Navigation and routing setup
│   ├── themeing/               # App theme, colors, and styles
│   └── utils/                  # Utility classes and helpers (e.g., BLoC observer)
│
├── features/                   # Feature-based modules
│   ├── checkout/               # Handles cart and checkout logic
│   │   ├── data/
│   │   │   ├── datasource/     # Local and remote data source contracts and implementations
│   │   │   ├── mapper/         # Mappers for data models
│   │   │   ├── models/         # Data Transfer Objects (DTOs) for checkout
│   │   │   └── repository/     # Repository implementation for checkout
│   │   ├── domain/
│   │   │   ├── entity/         # Business entities for checkout
│   │   │   ├── repository/     # Abstract repository for checkout
│   │   │   └── use_case/       # Checkout-specific use cases
│   │   └── presentation/
│   │       └── cart/           # BLoC, events, states, and UI for the cart screen
│   │
│   └── products/               # Handles product browsing, search, and details
│       ├── data/
│       │   ├── datasource/     # Data sources for products and categories
│       │   ├── mappers/        # Mappers for product and category models
│       │   ├── models/         # DTOs and local Isar models (.g.dart)
│       │   └── repository/     # Repository implementations
│       ├── domain/
│       │   ├── entity/         # Business entities for products
│       │   ├── repository/     # Abstract repositories
│       │   └── use_case/       # All use cases related to products
│       └── presentation/
│           ├── home/           # BLoC and UI for the home screen
│           ├── product_details/# BLoC and UI for the product details screen
│           ├── search/         # BLoC and UI for the search screen
│           └── widget/         # Reusable widgets specific to the products feature
│
└── main.dart                   # Application entry point
