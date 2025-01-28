# **Easy Tour**

## **Table of Contents**
1. [Introduction](#introduction)
2. [Tourist Features](#tourits_features)
2. [TourGuide Features](#tourguide_features)
3. [Screenshots](#screenshots)
4. [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
   - [Installation](#installation)
5. [Folder Structure](#folder-structure)
6. [Dependencies](#dependencies)
7. [How to Use](#how-to-use)
8. [Contributing](#contributing)
9. [License](#license)

---

## **Introduction**

mobile application related to tourism in Egypt combine (Tourists and TourGuides) to provide a good communication between them, which can enhance tourism in our lovely country.

---

## **Tourist Features**
- 🔹 Feature 1: Authentication (include Sign up,login,forgot password and profile) 
- 🔹 Feature 2: AI Trips (depending upon previous trips we make a suggestions for new trip) 
- 🔹 Feature 3: AI Transaltor (can help toursit for local egyptian language)  
- 🔹 Feature 4: Weather forecasting ( to see how the weather will be in the place where the tourist will visit ) 
- 🔹 Feature 5: Chat-Bot ( multi-languages chat bot can help tourist to ask for any further question related to egypt )
- 🔹 Feature 6: Flight Booking ( we provide booking plane trip with all features ) 
- 🔹 Feature 7: Hotel Booking ( we provide booking hotel from scratch untill get keys )
- 🔹 Feature 8: Booking trips with our tour guide who signed with us . 
- 🔹 Feature 9: real time chat including multi-media ( text,video,images and audios ) . 
- 🔹 Feature 10: Currency converter to help tourist what is the currecny of his country to egypt one . 
- 🔹 Feature 11: feed part ( like facebook we make small community that enable tourists and tour guide to share thier amazing times ) , 
- 🔹 Feature 12: Google-Map ( we provide high services like fetching places, make track and more ...).
- 🔹 Feature 13: Image Classification ( for tourist to reconginze to historical place we integrate with ai model to handle this).

---
## **TourGuide Features**
- 🔹 Feature 1: Authentication ( include Sign up,login,forgot password and profile) 
- 🔹 Feature 2: Creating Trips ( as tour guide we provide to you how can you add amazing trips to be seen from tourist )  
- 🔹 Feature 3: Handle requested on his trip to accept or refuse . 
- 🔹 Feature 4: real time chat including multi-media ( text,video,images and audios ) . 

## **Screenshots**

![Cover](https://github.com/user-attachments/assets/c08916dc-4118-4e2c-b420-011309032071)
 

---

## **Getting Started**

### **Prerequisites**
- Flutter SDK: `>=3.26.4`   

### **Installation**
1. Clone the repository:  
   ```bash
   git clone https://github.com/mahmoudSobhiAwad/Easy-Tour.git
   ```
2. Navigate to the project directory:  
   ```bash
   cd Easy-Tour
   ```
3. Get dependencies:  
   ```bash
   flutter pub get
   ```
4. Run the app:  
   ```bash
   flutter run
   ```

---

## **Folder Structure**

Explain the organization of your project. Example:  
```plaintext
lib/
├── core/            # Shared resources (constants, themes, utils)
├── features/        # Feature-specific folders (e.g., login, home, tasks)
│   ├── / Auth        # Home screen logic and UI
│   ├── / Tourist           # Home screen logic and UI
│   ├── / Tour Guide           # Home screen logic and UI           

main.dart            # Entry point of the app
```

---

## **Dependencies**

List key dependencies and their purpose. Example:  
- **Flutter Bloc**: State management  
- **Dio**: HTTP requests  
- **Hive**: Local storage  
- **Flutter Firebase Notifications**: For notifications  
- **Google Map Flutter**: For handling navigation  
- **Go Router**: For handling routing  
- **socket_io_clien**: For handling real time chat   
- **just_audio,Recor**: For handling audio  

To view the full list of dependencies, check the `pubspec.yaml` file.

---

## **How to Use**

1. Launch the app using `flutter run`.  
2. Log in or sign up to access the main features.  
3. Explore features like task management, priority settings, and more.  

---

## **Contributing**

Contributions are welcome! To contribute:  
1. Fork the repository.  
2. Create a new branch for your feature:  
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes and push to your branch:  
   ```bash
   git push origin feature-name
   ```
4. Create a Pull Request.

---

## **License**

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
