
# Pantry Pro Blueprint

## Overview

Pantry Pro is a Flutter application designed to help users manage their pantry inventory, track expiration dates, and generate recipes based on available ingredients.

## Style and Design

- **Theme:** The app will use a clean and modern design with a blue color scheme. It will support both light and dark modes.
- **Typography:** We'll use the `google_fonts` package to implement custom fonts for a unique and readable text style.
- **Layout:** The layout will be intuitive and user-friendly, with a focus on simplicity and ease of use.

## Features

### Implemented

- **Firebase Integration:**
  - Firebase Core for project connection.
  - Cloud Firestore for database.
  - Firebase Hosting for web deployment.
- **Basic App Structure:**
  - Provider for state management.
  - A basic router for navigation.
- **Authentication:**
  - Login screen with email and password fields.
  - Create account screen with email and password fields.
  - Authentication service to handle user creation and login with Firebase Authentication.
  - A redirect system that sends unauthenticated users to the login screen.
  - A logout button on the main screen.

### Current Plan: Pantry Management

- **Create Pantry Screen:**
  - A new screen that displays a list of pantry items.
  - A button to add a new item to the pantry.
- **Create Add Item Screen:**
  - A form to add a new item, including name, quantity, and expiration date.
- **Create Pantry Service:**
  - A service to handle adding, updating, and deleting pantry items in Firestore.
- **Update Navigation:**
  - The pantry screen will be the default screen after login.
