
# Pantry Pro Blueprint

## Overview

Pantry Pro is a Flutter application designed to help users manage their pantry, discover recipes, and reduce food waste. This document outlines the project's style, design, and features.

## Style and Design

- **Theme:** The app uses a simple theme with a blue primary swatch and a dark theme option.
- **Layout:** The app uses a bottom navigation bar for main navigation and a simple, clean layout for each screen.
- **Typography:** The app uses the default Flutter typography.

## Features

### Implemented Features

- **Authentication:** Users can register, log in, and log out using Firebase Authentication.
- **Routing:** The app uses `go_router` for navigation, with authentication-aware routing.
- **State Management:** The app uses `provider` for state management, including a `ThemeProvider` for light/dark mode and a `StreamProvider` for authentication state.
- **Main Navigation:** The app has a bottom navigation bar with three tabs: Pantry, Recipes, and Expiring Soon.

### Current Requested Change

- **Task:** Set up Firebase Authentication.
- **Status:** Completed.

