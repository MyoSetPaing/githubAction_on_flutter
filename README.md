# Recipe Finder App

A Flutter application that allows users to search for recipes based on the ingredients they have. This project is built using Clean Architecture principles and the BLoC pattern for state management.

## Features

*   **Search by Ingredients**: Enter a comma-separated list of ingredients to find matching recipes.
*   **Recipe Grid**: View search results in a responsive, staggered grid.
*   **State Management**: Utilizes `flutter_bloc` to manage application state in a predictable and scalable way.
*   **Offline Caching**: Caches the last successful search result using `Hive` for quick access.

## Architecture

This project follows **Clean Architecture** to separate concerns and create a more robust and maintainable codebase. The code is organized into three main layers:

*   **Presentation**: Contains the UI (Widgets) and state management logic (BLoC). It depends only on the Domain layer.
*   **Domain**: The core of the application. It contains the business logic, including entities, use cases, and repository interfaces. This layer has no external dependencies.
*   **Data**: Implements the repository interfaces defined in the Domain layer. It is responsible for fetching data from remote sources (API) and local sources (cache).

## Project Structure
recipe_finder/
├── lib/
│   ├── core/
│   │   ├── constant/
│   │   ├── di/
│   │   ├── error/
│   │   ├── platform/
│   ├── features/
│   │   ├── recipe_search/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   ├── models/
│   │   │   │   ├── repositories/
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   ├── repositories/
│   │   │   │   ├── usecases/
│   │   │   ├── presentation/
│   │   │   │   ├── bloc/
│   │   │   │   ├── pages/
│   │   │   │   ├── widgets/
│   │   ├── recipe_detail/
│   │   │   ├── ... (similar structure as recipe_search)
│   │   ├── meal_planning/
│   │   │   ├── ... (similar structure as recipe_search)
│   │   ├── favorites/
│   │   │   ├── ... (similar structure as recipe_search)
│   │   ├── main/
│   ├── app.dart
│   ├── main.dart


## Key Dependencies

*   `flutter_bloc`: For state management.
*   `flutter_staggered_grid_view`: For displaying recipes in a staggered grid layout.
*   `dartz`: For functional programming, specifically `Either` to handle failures and successes.
*   `dio`: For making network requests to the recipe API.
*   `hive`: For local data caching.
*   `equatable`: To simplify equality comparisons in models and states.

## Getting Started

### Prerequisites
*   Flutter SDK (version 3.x or higher)
*   An IDE like Android Studio or VS Code

### Installation
1.  **Clone the repository:**
    ```sh
    git clone <https://github.com/MyoSetPaing/recipe_finder>
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Run the app:**
    ```sh
    flutter run
    ```
