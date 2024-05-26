# Video Playlist App

This project is an iOS application that displays a list of videos fetched from a remote JSON endpoint. It utilizes the MVVM architecture and is built with Swift, Cocoapods, and includes unit tests.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Testing](#testing)
- [License](#license)

## Features

- Fetches and displays a list of videos from a remote JSON endpoint.
- Organized using the MVVM (Model-View-ViewModel) architecture.
- Includes unit tests to ensure code reliability and functionality.

## Requirements

- iOS 13.0+
- Xcode 14.0+
- Swift 5.0+

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/brams-9/quipper-test.git

2. pod install

3. open QuipperTest.xcworkspace


## Project Structure
The project follows the MVVM architecture with the following folder structure:

 Views: Contains the UI layer logic.

 ViewModels: Contains business logic and prepares data for the UI.

 Repository: Manages data operations, typically fetching from network or local database.

 Service: Contains networking logic to fetch data from external sources.

 Model: Contains the data models used in the app.


