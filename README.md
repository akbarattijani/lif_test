# 📝 Flutter Todo App (Technical Test)

## 🚀 Features

1.  **Authentication**:
    * Login with Email & Password (Firebase Authentication).
    * **Auto Login/Session Persistence**: User not login required when already login.
2.  **Dashboard (CRUD)**:
    * **Create**: Create new task
    * **Read**: Show all task (incomplete & completed)
    * **Update**: Update a task
    * **Delete**: Delete a task
3.  **Data Isolation & Persistence**:
    * All task store in **SQLite** (`sqflite`)
    * All task private (User A can't see User B tasks)

---

## 🛠 Tech Stack & Architecture

* **Framework**: Flutter SDK
* **Language**: Dart
* **Architecture**: MVC (Model - View - Controller)
* **State Management**: GetX
* **Auth**: Firebase Authentication
* **Local DB**: SQFlite
* **Networking**: Dio (not used for now)

### 📂 Project Structure

```text
lib/
├── components/          # Reusable Widgets (e.g., EditField)
├── const/               # Constants (Colors, Firebase Config, etc)
├── controllers/         # GetX Controllers (Business Logic)
├── data/                # Data Layer
│   ├── models/          # Data Models (e.g., Data model)
│   └── providers/       # Data Providers (e.g., DatabaseHelper, DioClient)
├── ui/                  # Views / Screens (e.g., Login, Dashboard)
└── main.dart            # Main
```


### 📂 List user login

```text
1.  email : admin@lif.id
    password : admin123
    
2.  email : op@lif.id
    password : op1234

3.  email : it@lif.id
    password : it1234
```


### 📂 How to run

1. open this project in `Android Studio`
2. open `Terminal`
3. run `flutter pub get`
4. run `flutter run` or Click the `Run` button at the top right of Android Studio




