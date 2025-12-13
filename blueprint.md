# Pantry Pro Blueprint

## Overview

Pantry Pro is a Flutter application designed to help users manage their pantry items and discover new recipes. It allows users to add, view, and delete pantry items, and it uses Firebase Firestore to store the data. The app now integrates with Google's Gemini AI to provide recipe suggestions based on the user's available ingredients, helping to reduce food waste.

## Features

### Implemented

*   **Pantry Item Management:** Users can add new items to their pantry, including the item's name, quantity, and expiration date.
*   **Firestore Integration:** The app is connected to a Firebase Firestore database to persist pantry items. All changes made in the app are automatically synced with the database.
*   **Real-time Updates:** The app uses a real-time stream of data from Firestore, so any changes made to the pantry are instantly reflected in the UI.
*   **AI-Powered Recipe Generation:** The app uses the Gemini AI model via the `firebase_ai` SDK to dynamically generate recipes.
*   **Expiration-Aware Suggestions:** The recipe generation prioritizes ingredients that are closest to their expiration date to help users reduce food waste.
*   **Recipe Viewing:** Users can view a list of suggested recipes and tap on any recipe to see its details, including ingredients and instructions.
*   **Dynamic UI:** The app's UI is built with Flutter and the Provider package, which allows for a dynamic and responsive user experience with a tab-based navigation for pantry and recipes.

### Future

*   **Search and Filter:** Implement a search bar for both pantry items and recipes.
*   **Favorite Recipes:** Allow users to save their favorite recipes for easy access later.
*   **Meal Planning:** Add a feature to create a weekly meal plan based on generated recipes.
*   **Improved UI/UX:** Enhance the app's design with a more modern and intuitive user interface, including animations and custom themes.
*   **Settings Screen:** Create a settings screen where users can customize the app's behavior, such as setting notification preferences or changing the theme.

## Design

### Architecture

The app follows a clean architecture pattern, with a clear separation of concerns between the UI, business logic, and data layers.

*   **Provider Package:** Used for state management (`PantryProvider`, `RecipeProvider`, `ThemeProvider`).
*   **Models:** `PantryItem` and `Recipe` models define the core data structures.
*   **Services:**
    *   `PantryProvider` encapsulates the business logic for pantry management.
    *   `RecipeProvider` handles the logic for generating recipes using the Gemini AI. It sorts ingredients by expiration date and constructs the prompt for the AI.
*   **UI:**
    *   The UI is composed of Flutter widgets, separated from the business logic.
    *   **`HomeScreen`:** Now features a `TabBar` to switch between the pantry list and recipe suggestions.
    *   **`RecipeList` & `RecipeListItem`:** Widgets for displaying the list of generated recipes.
    *   **`RecipeDetailsScreen`:** A dedicated screen to show the full details of a selected recipe.
*   **AI Integration:**
    *   The `firebase_ai` package is used to interact with the Firebase AI backend.
    *   The `gemini-pro` model is leveraged for its powerful text and instruction-following capabilities.

### Theming

The app uses a basic Material Design theme. The `primarySeedColor` is set to `Colors.deepPurple`, which gives the app a modern and stylish look. Further customization is planned for a future release.
