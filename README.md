# HealthCoach

## Description

HealthCoach is an iOS app designed to help users track their health and wellness goals. It provides features for monitoring daily activities, setting reminders, and visualizing progress.

## Features

- **Activity Tracking:** Log daily activities such as steps, calories burned, and exercise.
- **Reminders:** Set reminders for health-related tasks like drinking water or taking medication.
- **Progress Visualization:** View charts and graphs to track progress over time.
- **Custom Goals:** Set and manage personalized health goals.

## Technologies Used

- **UIKit:** For building the app's user interface.
- **Storyboard:** For designing the app's layout and navigation.
- **Swift:** The primary programming language used for development.
- **CoreData:** For local data storage and management.
- **HealthKit:** For integrating with Apple's health data.

## Installation Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/kevalthumar-inventyv/HealthCoach.git
   ```

2. Open the project in Xcode:

   ```bash
   cd HealthCoach
   open HealthCoach.xcodeproj
   ```

3. Build and run the project using Xcode.

## Project Structure

``` text
HealthCoach/
├── HealthCoach/
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── Info.plist
│   ├── Assets.xcassets/
│   ├── Controller/
│   │   ├── AppIntro/
│   │   ├── Home/
│   │   ├── Medication/
│   │   ├── More/
│   │   ├── MyDevices/
│   │   ├── OnBoarding/
│   │   ├── Settings/
│   │   ├── Welcome/
│   │   ├── login/
│   │   └── signup/
│   │   ├── SplashScreenViewController.swift
│   ├── Utilities/
│   ├── View/
│   └── ds_digital/
└── HealthCoach.xcodeproj/
└── README.md
└── HealthCoach Image/
```

## Controller Details

### Authentication

- **login/**: Handles user login functionality
- **signup/**: Manages user registration process
- **Welcome/**: Initial welcome screen controller

### Onboarding

- **AppIntro/**: Introduction screens for new users
- **OnBoarding/**: Initial setup and configuration screens

### Main Features

- **Home/**: Main dashboard and activity tracking
- **Medication/**: Medication management and reminders
- **MyDevices/**: Connected health devices management

### Additional Features

- **More/**: Additional settings and options
- **Settings/**: App configuration and user preferences

### Navigation

- **SplashScreenViewController.swift**: Initial loading screen

## Usage Instructions

1. Launch the app and grant necessary permissions (e.g., HealthKit access).
2. Navigate through the app using the bottom tab bar.
3. Log activities, set reminders, and view progress in the respective sections.

## HealthCoach Image

### HealthCoach Logo

![HealthCoach Logo](HealthCoach Image/HealthCoachLogo.png)

## Screenshots

### App Tour

![App Tour 1](https://i.imgur.com/zaXzTlQ.png)  
![App Tour 2](https://i.imgur.com/yflpNvu.png)  

### Authentication

![Login Screen](https://i.imgur.com/EqoyO0j.png)  
![Signup Process 1](https://i.imgur.com/bqoeMiy.png)  
![Signup Process 2](https://i.imgur.com/jvFH1Ys.png)  
![Signup Process 3](https://i.imgur.com/G6TWmZu.png)  

### HomeScreen

![HomeScreen](https://i.imgur.com/nrtPnfr.gif)

### Main Features

![Medication Screen](https://i.imgur.com/FOwEc9B.png)  
![Add Device 1](https://i.imgur.com/JopW3xe.png)  
![Add Device 2](https://i.imgur.com/dRhYvcO.png)  

### Settings

![Settings](https://i.imgur.com/CIwe1uk.png)  
![Settings 1](https://i.imgur.com/YMyvmCp.png)  
![Settings 3](https://i.imgur.com/anMlumJ.png)  

### More Section

![More Section](https://i.imgur.com/gGkxYfg.png)  

### Onboarding

![Onboarding](https://i.imgur.com/9hPmvjz.png)  

## Future Improvements

- **Social Features:** Add the ability to share progress with friends or join challenges.
- **Integration with Wearables:** Support for Apple Watch and other fitness devices.
- **Enhanced Analytics:** More detailed insights and personalized recommendations.
