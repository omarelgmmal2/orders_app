# Orders App
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/omarelgmmal2/orders_app)

Orders App is a comprehensive Flutter-based mobile application for a vegetable and produce e-commerce platform. It provides a complete shopping experience, from user authentication and product browsing to order placement and profile management.

## Features

- **User Authentication:** Secure login, registration, and password recovery flows.
- **Product Catalog:** Browse products by categories, view detailed product information with image sliders, and search for specific items.
- **Favorites:** Mark products as favorites for easy access.
- **Shopping Cart:** Add/remove items, adjust quantities, apply coupons, and view a summary of the cart.
- **Order Management:** Place new orders with specified delivery times and addresses. Track the status of current orders and view a history of completed orders.
- **Profile Management:** View and edit personal information, including name, phone number, and profile picture.
- **Address Management:** Add, edit, and delete multiple delivery addresses using an interactive Google Maps interface to pinpoint locations.
- **Wallet System:** Manage a personal wallet, view transaction history, and charge the balance.
- **Notifications:** Receive in-app notifications for order updates and promotions.
- **Localization:** Full support for both English (en) and Arabic (ar) languages.
- **Product Ratings:** View and submit ratings and comments for products.

## Tech Stack & Architecture

- **Framework:** Flutter
- **State Management:** Flutter BLoC (Business Logic Component)
- **Architecture:** Feature-based Clean Architecture separating UI, Business Logic, and Data.
- **Networking:** `dio` for handling API requests.
- **Dependency Injection:** `kiwi` for managing dependencies.
- **Localization:** `easy_localization` for multi-language support.
- **Mapping:** `google_maps_flutter` and `geolocator` for address and location services.
- **Local Storage:** `shared_preferences` for caching user data and session tokens.
- **UI Components:** `flutter_screenutil`, `carousel_slider`, `lottie`.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK installed. You can find instructions [here](https://flutter.dev/docs/get-started/install).

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/omarelgmmal2/orders_app.git
    ```

2.  **Navigate to the project directory:**
    ```sh
    cd orders_app
    ```

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Add API Keys:**
    This project uses Google Maps. You need to add your own API key.
    -   **Android:** Open `android/app/src/main/AndroidManifest.xml` and replace the placeholder value with your API key:
        ```xml
        <meta-data
            android:name="com.google.android.geo.API_KEY"
            android:value="YOUR_API_KEY_HERE"/>
        ```
    -   **iOS:** Open `ios/Runner/AppDelegate.swift` and replace the placeholder value with your API key:
        ```swift
        GMSServices.provideAPIKey("YOUR_API_KEY_HERE")
        ```

5.  **Run the application:**
    ```sh
    flutter run
    ```

## Project Structure

The project is structured to separate concerns, making it scalable and maintainable. The `lib` directory is organized as follows:

```
lib/
├── auth/           # Authentication screens (Login, Register, etc.)
├── core/           # Shared components, helpers, and utilities
│   ├── design/     # Common widgets (buttons, inputs)
│   ├── logic/      # Core business logic (Dio, CacheHelper)
│   └── utils/      # Constants (colors, strings, styles)
├── features/       # BLoC logic for each application feature
├── generated/      # Auto-generated files for localization
├── model/          # Data models for API responses
├── splash/         # Splash screen
└── views/          # UI screens and widgets, organized by feature
