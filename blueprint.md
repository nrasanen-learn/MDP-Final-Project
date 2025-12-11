
# Pantry Pro - Application Blueprint

## Overview

Pantry Pro is a smart pantry management application designed to help users keep track of their food inventory, reduce food waste, and streamline their grocery shopping. By leveraging Firebase for backend services, the app provides a real-time, multi-device experience.

## Style and Design

*   **Theme:** Modern, clean, and intuitive, utilizing Material 3 design principles.
*   **Color Palette:** A vibrant and energetic look and feel, with a primary color of deep purple. A noise texture will be applied to the main background for a premium, tactile feel.
*   **Typography:** Expressive and clear typography using Google Fonts. `Oswald` for headings and `Roboto` for body text.
*   **Iconography:** Material Design icons to enhance clarity and navigation.
*   **Interactivity:** Modern, interactive components with subtle animations and "glow" effects for a polished user experience.

## Implemented Features

*   **Firebase Integration:** Core Firebase services (`firebase_core`, `firebase_auth`, `cloud_firestore`) are integrated.
*   **Basic Theming:** A `ThemeProvider` is set up to manage light and dark modes.
*   **Navigation:** `go_router` is configured for basic routing.

## Development Plan: Authentication

Our first major goal is to implement a complete authentication system.

### 1. Create Authentication Service

*   Create a file at `lib/services/firebase_auth_service.dart`.
*   This service will encapsulate all Firebase Auth logic:
    *   `signInWithEmailAndPassword`
    *   `createUserWithEmailAndPassword`
    *   `signOut`
    *   A stream to listen to `authStateChanges`.

### 2. Build UI Screens

*   **Login Screen (`lib/screens/login_screen.dart`):**
    *   Email and password input fields.
    *   "Login" and "Sign Up" buttons.
    *   A toggle to switch between login and registration forms.
*   **Authentication Wrapper (`lib/widgets/auth_wrapper.dart`):**
    *   This widget will listen to the authentication state stream from `FirebaseAuthService`.
    *   If the user is logged in, it will show the `HomeScreen`.
    *   If the user is logged out, it will show the `LoginScreen`.

### 3. Update `main.dart` and Router

*   Modify the `main` function to use a `StreamProvider` for the authentication state.
*   Update the `go_router` configuration to use the `AuthWrapper` as the initial route.
*   Define routes for `/login` and `/`.

### 4. Create Placeholder Screens

*   Create basic, stateless placeholder widgets for the main application screens to facilitate navigation setup:
    *   `lib/screens/home_screen.dart`
    *   `lib/screens/add_pantry_item_screen.dart`
    *   `lib/screens/settings_screen.dart`
