M1 SHIPPING REELS APPLICATION
Project Overview

This is a Flutter application developed as part of the technical assessment.
The application displays a reels-style vertical video feed with pagination, pull-to-refresh, and caching functionality.

The project follows Clean Architecture principles and uses BLoC for state management.

FEATURES

Vertical reels-style scrolling (PageView)

Pagination (infinite scrolling)

Pull-to-refresh functionality

Video caching using flutter_cache_manager

Clean Architecture implementation

BLoC state management

Dependency Injection using get_it

Shimmer loading effect

Brand-aligned UI (based on M1 Shipping)

"Visit Website" CTA that opens the official website externally

TECHNOLOGIES USED

Flutter

Dart

flutter_bloc

get_it

http

video_player

flutter_cache_manager

shimmer

url_launcher

INSTALLATION STEPS

Clone the repository

git clone <repository-url>
cd <project-folder>

Install dependencies

flutter pub get

Run the application

flutter run

Ensure a device or emulator is connected before running.

ANDROID REQUIREMENT

Make sure AndroidManifest.xml includes internet permission:

<uses-permission android:name="android.permission.INTERNET"/>
IOS REQUIREMENT

If running on iOS and encountering dependency issues:

cd ios
pod install

Then run:

flutter run

HOW TO RUN THE APPLICATION

Connect a physical device or start an emulator.

Run the following command from project root:

flutter run

The application will launch and display the reels-style video feed.

PROJECT STRUCTURE

lib/

core/

di/ Dependency Injection setup

error/ Custom exceptions

network/ API client

features/
reels/
data/
datasource/ Remote data source
models/ Data models
repositories/ Repository implementation

domain/
entities/    Business entities
repositories/ Repository contracts
usecases/    Business logic

presentation/
bloc/        BLoC state management
pages/       UI screens
widgets/     Reusable UI components


main.dart Application entry point

ARCHITECTURE

The application follows Clean Architecture principles:

Presentation Layer

UI components

BLoC state management

Domain Layer

Entities

Repository interfaces

Use cases

Data Layer

Remote data source

Repository implementation

This structure ensures scalability, maintainability, and separation of concerns.

PAGINATION IMPLEMENTATION

Pagination is implemented using PageView.builder.

When the user scrolls near the last two items, a new page of data is fetched and appended to the existing list.

CACHING STRATEGY

Video caching is implemented using flutter_cache_manager.

Videos are downloaded once.

Files are stored locally.

Subsequent loads reuse cached files.

Reduces repeated network calls and improves performance.

API HANDLING

The provided API endpoint is called as instructed.

Since the endpoint does not return usable data, structured dummy JSON data is used while maintaining:

HTTP call structure

Pagination behavior

Clean Architecture flow
