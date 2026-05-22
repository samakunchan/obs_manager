# OBS Manager

A modern, robust Flutter application to manage OBS (Open Broadcaster Software), built to replace `obs_for_sama` step by step.

The main objective is to provide a clean, modular, and highly responsive control panel (Stream Deck style) for mobile, tablet, and desktop systems.

---

## 🏗️ Architecture & Technology Stack

Following modern, expert Flutter development patterns, `obs_manager` is designed from the ground up to be scalable, clean, and highly testable:

*   **State Management**: `signals_flutter` (Signals) for fast, reactive, granular UI updates.
*   **Dependency Injection**: `get_it` for decoupling and service registration.
*   **Functional Programming**: `dartz` for robust, type-safe error handling and failure models (e.g. standard `Either<Failure, Success>`).
*   **Networking Layer**: A robust HTTP service using `dio` and clean exception layers.
*   **Responsive Layout**: `sizer` for dynamic viewport support on mobile and tablet.
*   **OBS Integration**: Direct socket communication utilizing `obs_websocket`.

---

## 🚀 Migration Roadmap (From `obs_for_sama`)

To replace `obs_for_sama` smoothly, the refactoring and feature migration follows this path:

1.  **Project Initialization** [DONE]
    *   Set up dependencies, dev dependencies, and strict static analysis rules (`very_good_analysis`).
2.  **Core Services & Storage** [UPCOMING]
    *   Local caching (`shared_preferences`) and configuration forms (IP, Port, Password).
    *   Wired network status detector (`connectivity_plus`).
3.  **Error & Exception Handling**
    *   Implement strictly typed exception wrappers and failure mapping.
    *   Develop a solid global or local UI error-view boundary.
4.  **Websocket Connection & Handshake**
    *   Automate QR-code registration scanner (`mobile_scanner`).
    *   Manage connection lifecycle states (loading, active, disconnected, reconnection back-off).
5.  **Scenes & Sources control**
    *   Listen to real-time events from OBS and toggle scenes, sound volumes, and streaming controls seamlessly.

---

## 🛠️ Getting Started

### Prerequisites

1.  Install the **OBS WebSocket plugin** on your OBS machine:
    *   [OBS WebSocket releases (OBS 28+ includes this built-in)](https://github.com/obsproject/obs-websocket/releases)
    *   Ensure you have the server **IP address**, **Port**, and **Password** configured.
2.  Install the **Flutter SDK** (recommended version `3.10.x` or above).

### Commands

To fetch dependencies:
```bash
flutter pub get
```

To run the application:
```bash
flutter run
```

To run build_runner for code generation (freezed, json_serializable):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 📱 Platform Configuration & Caveats

### Android
*   **Kotlin & Gradle Versions**: To adjust version alignments, look at `/android/settings.gradle` and `/android/gradle/wrapper/gradle-wrapper.properties`.
*   **Impeller**: If rendering issues occur on older devices, Impeller can be disabled or configured in `AndroidManifest.xml`.

### Windows (Desktop Platform)
*   Integrates `bitsdojo_window` for premium custom framing and title bars.
*   QR-code scanning via camera is automatically disabled on Windows.
