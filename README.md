# LinkYou Task App

A Flutter app for managing tasks and user authentication.

## Features
- User login and logout
- Task management
- Persistent authentication

## How to Run
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/linkyou_task.git
2.Install dependencies:
flutter pub get
3.Run the app:
flutter run

Dependencies
flutter_bloc: State management

dio: HTTP requests

shared_preferences: Persistent storage

Design Decisions
1. State Management: BLoC Pattern
Why BLoC?

The BLoC (Business Logic Component) pattern was chosen for its scalability and separation of concerns. It allows for clean and maintainable code by separating the UI from the business logic.

BLoC also works well with streams, making it ideal for handling asynchronous operations like API calls and database interactions.

Implementation:

Used flutter_bloc to manage state for both authentication (AuthBloc) and task management (TaskBloc).

Events and states were defined for each feature to handle user interactions and data flow.

2. Dependency Injection: GetIt
Why GetIt?

GetIt was chosen for dependency injection because it is lightweight and easy to use. It allows for efficient management of dependencies across the app.

It simplifies the process of providing dependencies to BLoCs, repositories, and data sources.

Implementation:

Registered all dependencies (e.g., AuthRepository, TaskRepository, Dio, SharedPreferences) in service_locator.dart.

Used registerFactory for BLoCs and registerLazySingleton for repositories and data sources.

3. Persistent Authentication
Why SharedPreferences?

SharedPreferences was chosen for its simplicity and ease of use. It allows for storing small amounts of data (e.g., user ID or token) persistently.

It ensures that users remain logged in even after closing and reopening the app.

Implementation:

Saved the user ID to SharedPreferences after a successful login.

Checked for a saved user ID on app startup to determine if the user is already logged in.

4. Networking: Dio
Why Dio?

Dio was chosen over the default http package because it provides advanced features like interceptors, request cancellation, and better error handling.

It simplifies the process of making HTTP requests and handling responses.

Implementation:

Configured Dio with interceptors for logging requests and responses.

Used Dio in AuthRemoteDataSource and TasksRemoteDataSources to interact with the backend API.

5. Local Storage: Hive
Why Hive?

Hive was chosen for local storage because it is fast, lightweight, and supports complex data types.

It is ideal for storing tasks locally and syncing them with the backend when needed.

Implementation:

Registered a TasksAdapter for the Tasks model.

Used a Hive box to store and retrieve tasks locally.


Challenges Faced
1. Handling Asynchronous Operations
Challenge: Managing asynchronous operations like API calls and database interactions while keeping the UI responsive.

Solution: Used the BLoC pattern to handle asynchronous events and states. This ensured that the UI remained responsive and updated correctly based on the app's state.

2. Persistent Authentication
Challenge: Implementing persistent authentication so that users remain logged in even after closing the app.

Solution: Used SharedPreferences to store the user ID and checked for it on app startup. This allowed for seamless authentication without requiring the user to log in repeatedly.

3. Dependency Injection
Challenge: Managing dependencies across multiple layers (e.g., BLoCs, repositories, data sources).

Solution: Used GetIt to centralize dependency registration and injection. This made the codebase more modular and easier to maintain.

4. Error Handling
Challenge: Handling and displaying errors gracefully (e.g., network errors, invalid credentials).

Solution: Implemented error states in the BLoC and displayed meaningful error messages to the user using BlocConsumer.


