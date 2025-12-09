# Pantry Pro Blueprint

## Overview

Pantry Pro is a mobile application designed to help users manage their kitchen inventory, reduce food waste, and discover new recipes. The app allows users to track items in their pantry, monitor expiration dates, and get recipe suggestions based on the ingredients they have on hand.

## Implemented Features

### Core

*   **Project Setup:** Standard Flutter project structure.
*   **Splash Screen:** A simple and elegant splash screen that appears when the app is launched.
*   **Routing:** A declarative routing solution using the `go_router` package for seamless navigation.
*   **Theme:** A customizable theme with support for light, dark, and system modes, managed with the `provider` package.
*   **Providers:** Centralized state management using `provider` for the theme, pantry, and recipes.

### Screens

*   **Main Screen:** A shell screen that hosts the bottom navigation bar for seamless navigation between the main sections of the app.
*   **Pantry Screen:** The main screen of the app, which displays a list of all items in the user's pantry. It also includes a floating action button to add new items.
*   **Recipes Screen:** A screen that displays a grid of available recipes using a `RecipeCard` widget.
*   **Recipe Details Screen:** A screen that shows the details of a selected recipe, including an image, ingredients, and instructions.
*   **Expiring Soon Screen:** A screen that lists all pantry items that are nearing their expiration date.
*   **Settings Screen:** A screen that allows users to select their preferred theme (light, dark, or system) and view information about the app.
*   **Suggested Recipes Screen:** A screen that displays recipes that can be made with the ingredients in the user's pantry.

### Widgets

*   **Add Pantry Item Dialog:** A user-friendly dialog with icons and a date picker for adding new items to the pantry.
*   **RecipeCard:** A card widget that displays recipe information in an attractive and organized way.
*   **PantryListItem:** A custom list item widget for the pantry screen with a modern design and a delete button.

## Current Plan

### Next Steps

1.  **Bug Fixes:** Resolved several bugs related to missing `id` and `imageUrl` fields in models, incorrect use of the `intl` package, and incorrect provider access.
2.  **Search Functionality:** Add a search bar to the `RecipesScreen` to allow users to search for specific recipes.
3.  **UI/UX Enhancements:**
    *   Add animations to enhance the user experience.
    *   Add placeholder images for recipes that don't have one.
4.  **Testing:** Write unit and widget tests to ensure the app is working correctly.
5.  **Firebase Integration:**
    *   Use Firebase to store pantry items and recipes.
    *   Implement user authentication.
