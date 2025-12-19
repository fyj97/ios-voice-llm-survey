# Questionnaire LLM iOS App

A Swift-based iOS application that helps field researchers collect qualitative feedback about specific locations or streets. The app can record audio, transcribe speech, and leverage LLM to match responses with questionnaire questions.

## Feature Highlights

- **Audio Capture** – Start and stop recording with a single tap
- **Immediate Playback** – Review the captured audio without leaving the app
- **Speech-to-Text** – Convert recordings to text using Apple's Speech framework
- **LLM Matching** – Send transcripts to LLM API (OpenAI or Gemini) and align answers with questionnaire items
- **Multi-API Support** – Choose between OpenAI and Gemini API providers (OpenAI recommended for better results)
- **API Key Management** – Configure API keys for both providers through in-app settings (no code modification required)
- **JSON Export** – Save structured results for reporting or sharing
- **On-Device Aggregation** – Summarize previously exported survey data into human-readable stats
- **Questionnaire Browsing** – View the complete questionnaire question list within the app
- **Respondent Information** – Collect and manage basic information about respondents

## Project Structure

```
CounterApp/
├── CounterApp.xcodeproj          # Xcode project file
├── CounterApp/                    # Main application directory
│   ├── AppDelegate.swift          # Application delegate
│   ├── SceneDelegate.swift       # Scene delegate
│   ├── ViewController.swift      # Main view controller (recording and playback)
│   ├── QuestionnaireModels.swift # Questionnaire data models
│   ├── LLMService.swift          # LLM API service
│   ├── QuestionnaireViewController.swift  # Questionnaire browsing view
│   ├── QuestionPageViewController.swift    # Question detail view
│   ├── RespondentInfoViewController.swift # Respondent information view
│   ├── LocationAggregationViewController.swift # Data aggregation view
│   ├── questionnaire.json        # Questionnaire configuration file
│   ├── Base.lproj/               # Storyboard files
│   │   ├── Main.storyboard
│   │   └── LaunchScreen.storyboard
│   └── Assets.xcassets/          # Application assets
├── CounterAppTests/              # Unit tests
├── CounterAppUITests/            # UI tests
└── README.md                     # This file
```

## Getting Started

### Prerequisites

- **macOS** – Required to run Xcode
- **Xcode 15.0 or later** – For development and building the app
- **iOS 17.0 or later** – Supports simulator or physical device
- **Swift 5.0 or later** – Programming language version requirement
- **LLM API Key** – OpenAI or Gemini API key for LLM functionality (can be configured in-app)
  - **OpenAI API Key** (Recommended) – Get from: https://platform.openai.com/api-keys
  - **Gemini API Key** (Alternative) – Get from: https://makersuite.google.com/app/apikey
  - **Note**: OpenAI generally provides better results for this use case, but Gemini is also supported

### Running the App

1. **Clone or Download the Project**
   ```bash
   # If cloning from GitHub
   git clone <repository-url>
   cd week5/CounterApp
   ```

2. **Open the Project**
   ```bash
   open CounterApp.xcodeproj
   ```
   Or double-click `CounterApp.xcodeproj` in Finder

3. **Select a Target Device**
   - Choose a target device from the top toolbar in Xcode
   - You can select an iOS simulator (e.g., iPhone 15, iPhone 15 Pro, etc.)
   - Or connect a physical device for testing

4. **Verify Configuration Files**
   - In Xcode's project navigator, ensure the `questionnaire.json` file is included in the `CounterApp` folder
   - Check that the file is added to the project target (check Target Membership in File Inspector)

5. **Build and Run**
   - Press **⌘ + R** or click the Run button in the top-left corner of Xcode
   - The first run may take a few minutes as dependencies are downloaded and compiled
   - If you encounter signing issues, configure your developer account in Signing & Capabilities

6. **Configure LLM API Key**
   - After launching the app, tap the **Settings** button in the top-right corner of the navigation bar
   - **Select API Provider**: Choose between OpenAI or Gemini
     - **OpenAI** (Recommended) – Generally provides better accuracy and results for questionnaire matching
     - **Gemini** (Alternative) – Supported as an alternative option
   - **Configure API Keys**: Enter API keys for your chosen provider(s)
     - OpenAI API key: Get from https://platform.openai.com/api-keys
     - Gemini API key: Get from https://makersuite.google.com/app/apikey
   - The API keys will be securely stored in UserDefaults and persist across app launches
   - **Important**: You must configure at least one API key before using the LLM Recognition feature
   - **Note**: You can configure both API keys and switch between providers at any time in settings

7. **Permission Settings**
   - When using the recording feature for the first time, the app will request microphone permission
   - When using the speech recognition feature for the first time, the app will request speech recognition permission
   - Please tap "Allow" in the system permission dialog
   - If you accidentally denied permission, you can re-authorize in Settings > Privacy & Security > Microphone/Speech Recognition

## Usage Guide

### Basic Workflow

1. **Record Audio**
   - Tap the "Record" button to start recording
   - Tap again to stop recording
   - Recording status will be displayed in the status label

2. **Playback Recording**
   - After recording, tap the "Play" button to playback the recording
   - Ensure the recording was successful before proceeding

3. **Speech-to-Text**
   - After recording, the app will automatically perform speech recognition
   - Transcription results will be displayed on the interface

4. **LLM Matching**
   - Tap the "LLM Recognition" button
   - The app will send the transcription text to the selected LLM API (OpenAI or Gemini)
   - Returns matched questionnaire questions and extracted answers
   - **Note**: OpenAI is recommended for better accuracy, but you can switch to Gemini in settings if preferred

5. **View Questionnaire**
   - Tap the document icon in the navigation bar to view the complete questionnaire
   - You can browse all questions and their types

6. **Fill Respondent Information**
   - You can fill in basic information about respondents during the questionnaire flow
   - Includes name, age, gender, phone, and location

7. **Export Data**
   - Tap the "Export JSON" button to export survey results
   - Files will be saved to the app's Documents directory
   - Can be accessed through the Files app or iTunes file sharing

8. **Data Aggregation**
   - Tap the "Aggregate" button to view statistics of exported data
   - Can aggregate multiple survey results and generate reports

## Key Concepts Covered

This application covers the following core iOS development technologies:

- **UIKit Fundamentals** – View controllers, storyboards, and Auto Layout
- **Audio APIs** – Recording and playback using `AVFoundation`
- **Speech Recognition** – Converting audio files to text via the `Speech` framework
- **Networking** – Calling LLM REST APIs (OpenAI and Gemini) using `URLSession`
- **JSON Handling** – Decoding and encoding structured survey data using the `Codable` protocol
- **File Management** – Writing export files to the app's documents directory using `FileManager`
- **User Preferences** – Securely storing API keys and app settings using `UserDefaults`
- **Navigation Controller** – Managing view hierarchy using `UINavigationController`
- **Data Models** – Defining data models using Swift structs and enums

## Tech Stack

- **Development Language**: Swift 5.0+
- **Minimum iOS Version**: iOS 17.0
- **Development Tool**: Xcode 15.0+
- **Main Frameworks**:
  - `UIKit` - User interface
  - `AVFoundation` - Audio recording and playback
  - `Speech` - Speech recognition
  - `Foundation` - Basic functionality (JSON, file management, etc.)

## Contributing

Welcome to submit Issues and Pull Requests to improve this project!

## License

This project is intended for educational use. Feel free to adapt and extend it for your own research workflows.
