# TVMaze

TVMaze app is a user-friendly application designed to keep you updated with your favorite TV series. Leveraging the comprehensive database provided by the TVMaze API, the app offers an extensive catalog of TV series, from timeless classics to the latest hits.

## Features

- **Browse & Discover:** Effortlessly navigate through a vast collection of TV series, organized for easy discovery of new and trending content.
- **Detailed Information:** Get in-depth details about each series, including cast members, airing schedules, episode guides, and much more.
- **Favorites:** Mark series as favorites for quick access anytime. Stay on top of the series you love by receiving updates on new episodes and seasons.
- **Search Functionality:** Find exactly what you're looking for with our responsive search feature. Whether you know what you want or just exploring, finding your next binge-watch has never been easier.
- **Up-to-Date:** The app syncs with the TVMaze database in real-time, ensuring you have the most current information at your fingertips.

## Images

| Home    | Favorites |
| -------- | ------- |
| <img src="https://github.com/felipemendes/TVMaze/assets/3712089/50c933f6-f707-47fd-9e60-f136a903a131">  | <img src="https://github.com/felipemendes/TVMaze/assets/3712089/9d64328c-6b68-434d-85ae-0145a8c7691c">     |

| TV Show Details    | Search |
| -------- | ------- |
| <img src="https://github.com/felipemendes/TVMaze/assets/3712089/a9d88e10-49cb-48ff-b0a8-09e3abf6bf8a">  | <img src="https://github.com/felipemendes/TVMaze/assets/3712089/05ad3525-1a41-42c0-b1b4-52c184cfd976">    |

| Episode Details    | Settings |
| -------- | ------- |
| <img src="https://github.com/felipemendes/TVMaze/assets/3712089/7f6af9fc-dcbf-41cd-9ad6-9d08bd42bbae">  | <img src="https://github.com/felipemendes/TVMaze/assets/3712089/c0fe22cc-5406-4526-b5e4-38df6db1fa22">    |

## Getting Started

To run this project, follow these steps:

1. Clone the repository to your local machine.
```bash
git clone git@github.com:felipemendes/TVMaze.git
```

2. Navigate to the project directory.
```bash
cd TVMaze
```

3. Open the project in Xcode.
```bash
open TVMaze.xcodeproj
```

4. Build and run the project.

## Technical Features

- MVVM-C (Model-View-ViewModel-Coordinator) architecture pattern using Swift
- REST API
- SwiftUI
- Swift Package Manager
- Combine framework
- Local Image Storage
- View State Handling
- Convenience Initializers
- SOLID principles
- Clean Code principles
- Unit testing with XCTest

## MVVM Architecture

### Structure:

1. **View (SwiftUI View)**
- Responsible for presenting the UI.
- Binds to the *ViewModel* to display data and send user actions.

2. **ViewModel**
- Connected below the *View* in the diagram.
- Has a bidirectional connection to the *View* (via *@Published* properties in the *ViewModel* and *@ObservedObject* or *@StateObject* in the *View* for data binding).
- Handles business logic and prepares data for display.
- Communicates with the **Model** to retrieve or update data.

3. **Model**
- Positioned at the bottom layer in the diagram.
- Connected to the *ViewModel*, indicating that the *ViewModel* can access or modify the Model.

### Relationships

1. **View <-> ViewModel**
- The *View* observes changes in the *ViewModel* through data binding.
- The *ViewModel* updates its properties based on user actions forwarded from the *View*, and these changes are reflected back in the *View*.

2. **ViewModel -> Model**
- The *ViewModel* can request data from the *Model* or update it.
- This is a one-way relationship from the *ViewModel's* perspective but may involve callbacks or completion handlers for asynchronous operations.

3. **Model**
- Contains the essential data but does not have direct knowledge of the *View* or *ViewModel*.
- It might include business rules or data manipulation methods.

<img src="https://github.com/felipemendes/TVMaze/assets/3712089/ee76dd68-38b1-4e07-b04c-e79afb1c7087">

## Project 

### TVMaze iOS app

1. **TV Shows Overview:** Dive into an extensive catalog of TV series, meticulously compiled and updated from the TVMaze API. This feature allows users to browse through various genres, ratings, and much more.

2. **Detailed Series Insights:** Access in-depth information about each TV series, including synopsis, season breakdowns, and airing schedules. This section is your go-to resource for everything you need to know about your favorite series.

3. **Episode Insights:** Delve deeper into individual episodes with detailed descriptions. Explore behind-the-scenes content and trivia to enhance your viewing experience.

4. **Favorites Collection:** Personalize your app experience by curating a list of your favorite TV shows. This feature enables easy access to your preferred series, ensuring you never miss an update or new episode release.

5. **Advanced Search Functionality:** Utilize our powerful search feature to quickly find TV series by name. Whether you’re looking for a specific show or exploring new options, our search tool helps you navigate our vast database with ease.

6. **Settings and Security:** Take control of your app experience with customizable settings, including the ability to secure the application with a PIN number or Fingerprint Authentication. This feature adds an extra layer of security, safeguarding your personal preferences and favorites list.

### TVMazeServiceKit Packages
- Within this package, a distinct module named *TVMazeServiceKit* has been introduced to centralize and manage reusable data managers utilized across various parts of the application. By organizing the shared managers in this manner, it promotes consistency, enhances maintainability, and simplifies the development process by allowing developers to easily access and utilize these components throughout the project. This modular approach fosters cleaner and more efficient code architecture, facilitating smoother collaboration among team members and ensuring a cohesive user experience across different features.

<img src="https://github.com/felipemendes/TVMaze/assets/3712089/69d50856-d92e-4cce-b82d-8e1f2475ecbf">

## Roadmap: Enhancements and Features

- Create a people search with person details
- HTML Content Sanitization
- Pagination Support
- Improve Custom UI Modifiers
- String Localization
- Coordinator Pattern
- Unit Testing Expansion
