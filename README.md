# Eventify 🎉

A full-featured Flutter event management app that lets users discover public events, manage private invitations, share memories, and connect with attendees — all in one place.

---

## Features

### 🌐 Public & Private Events
- Browse all public events available to everyone
- Receive private invitations via email or phone number
- Accept or decline invitations with instant notifications
- Join events with one tap

### 📅 Calendar View
- See upcoming events in a calendar layout
- Quickly spot available events by date

### 📸 Photos & Videos
- Take photos during events and upload them instantly
- Everyone who attended the same event can view shared photos
- Delete your own uploaded photos and videos

### 💬 Event Chat
- Built-in group chat for each event
- Attendees can communicate before and during the event

### 🔔 Notifications
- Get notified when an event is coming up
- Instant notification when someone sends you an invitation
- Accept or decline directly from the notification

### ➕ Create Your Own Events
- Create public or private events
- Invite specific people by email or phone number

---

## Tech Stack

| Category | Technology |
|---|---|
| Framework | Flutter (Dart) |
| State Management | Flutter BLoC |
| Authentication | Firebase Auth, Google Sign-In, Facebook Auth |
| Database | Cloud Firestore |
| Storage | Supabase Storage |
| Maps | Google Maps Flutter |
| Notifications | Firebase Cloud Messaging (FCM) |
| Media | Image Picker, Video Player |
| Localization | Flutter Localizations (Arabic / English) |
| Calendar | Table Calendar |

---

## Screenshots

> Coming soon

---

## Getting Started

### Prerequisites
- Flutter SDK `^3.7.0`
- Firebase project configured for Android & iOS
- Google Maps API key
- Supabase project

### Installation

```bash
git clone https://github.com/ITIFinalProject/final-project-mobile.git
cd final-project-mobile
flutter pub get
flutter run
```

### Environment Setup
Create a `.env` file in the root directory and add your API keys:
```
GOOGLE_MAPS_API_KEY=your_key_here
SUPABASE_URL=your_url_here
SUPABASE_ANON_KEY=your_key_here
```

---

## Project Structure

```
lib/
├── core/           # Constants, themes, utilities
├── features/       # Feature-based modules (events, auth, chat...)
└── main.dart
```

---

## Team

Built as a final project at **ITI (Information Technology Institute)** by a cross-functional mobile development team.

---

## License

This project is for educational purposes.
