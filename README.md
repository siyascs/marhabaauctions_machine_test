# Flutter Image Description App (Camera + LLM)

This Flutter app lets a user:
1. Capture a photo from the camera (or pick from gallery).
2. Send that image to an LLM with vision support.
3. Show a human-readable description of the image.

## Tech stack
- Flutter + Dart
- `image_picker` for camera/gallery image selection
- `http` for API calls
- OpenAI Chat Completions API (`gpt-4o-mini` by default)

## Setup

### 1) Install dependencies
```bash
flutter pub get
```

### 2) Provide API key at run-time
Use `--dart-define` so secrets are not hard-coded:

```bash
flutter run --dart-define=OPENAI_API_KEY=your_openai_api_key
```

## How it works
- `ImageDescriptionPage` handles image selection and UI state.
- `VisionApiService` converts the selected image to base64 and sends it to the LLM.
- The generated description is rendered in the UI.

## File structure
- `lib/main.dart`
- `lib/features/image_description/presentation/pages/image_description_page.dart`
- `lib/features/image_description/data/vision_api_service.dart`

## Platform notes
### Android
- `INTERNET` and `CAMERA` permissions are declared in `AndroidManifest.xml`.

### iOS
- `NSCameraUsageDescription` and `NSPhotoLibraryUsageDescription` are declared in `Info.plist`.

## Future enhancements
- Add BLoC/Cubit for state management.
- Add loading skeleton and better error cards.
- Keep description history locally.
- Let users choose language/tone of generated descriptions.
