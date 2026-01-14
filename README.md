# Octopus Mobile

The official mobile application for the **Octopus** collaboration ecosystem. Built with **Flutter**, this app provides a high-performance, real-time experience for team coordination and project management on both **Android** and **iOS**.

---

## 📖 Project Overview

**Octopus Mobile** is the mobile extension of the Octopus platform. It bridges the gap between the desktop experience and on-the-go productivity. By connecting to the [Octopus Backend](https://github.com/hoangdh2001/octopus-be) microservices, it enables users to stay synchronized with their teams through real-time data streaming and intuitive task management.

---

## ✨ Key Features

* **Real-time Communication**: Instant messaging and group chats powered by **Socket.io**.
* **Workspace Mobility**: Create, edit, and track tasks or boards directly from your mobile device.
* **Live Updates**: Real-time synchronization of project statuses across all devices.
* **Push Notifications**: Stay informed with instant alerts for mentions, assignments, and deadlines.
* **Rich Media**: Support for file attachments and image sharing via the storage service.

---

## 🛠️ Tech Stack

| Category | Technology |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev/) |
| **Language** | Dart |
| **Real-time Engine** | [Socket.io Client](https://pub.dev/packages/socket_io_client) |
| **Networking** | Dio / Retrofit |
| **Local Storage** | Hive / Shared Preferences |
| **Architecture** | Clean Architecture (Data, Domain, Presentation) |

---

## 🚀 Getting Started

### Prerequisites
* **Flutter SDK**: `^3.x.x`
* **Dart SDK**: `^3.x.x`
* **Backend**: Ensure the [Octopus Backend](https://github.com/hoangdh2001/octopus-be) services are running.

### Installation

1.  **Clone the repository**:
    ```bash
    git clone [https://github.com/hoangdh2001/octopus-mobile.git](https://github.com/hoangdh2001/octopus-mobile.git)
    cd octopus-mobile
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Environment Setup**:
    Locate your configuration file (e.g., `lib/core/config/app_config.dart` or `.env`) and update the endpoints:
    ```dart
    const String BASE_URL = "http://your-gateway-url:8080";
    const String SOCKET_URL = "http://your-message-service-url:port";
    ```

4.  **Run the application**:
    ```bash
    # Run in debug mode
    flutter run
    ```

---

## 🏗️ Project Structure

The project follows a modular structure to maintain scalability:

```text
lib/
├── core/          # Global configs, themes, and network interceptors
├── data/          # Repository implementations and Data Sources (API/Socket)
├── domain/        # Business logic: Entities and Use Cases
├── presentation/  # UI Layer: Screens, Widgets, and State Management
└── main.dart      # App initialization and routing setup
```
## 🔌 Socket.io Implementation
* The app maintains a persistent WebSocket connection for instant features:

* Events Handled: onMessage, onTyping, onNotification.

*Performance: Optimized to minimize battery consumption while maintaining a live connection in the background.

## 🚢 Build & Release
To generate production builds:
```bash
# For Android (APK)
flutter build apk --release
```
```bash
# For iOS
flutter build ios --release
```
