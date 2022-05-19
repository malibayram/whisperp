# whisperp

A new Flutter project.

## Styles

## Development

- We will use git feature branching strategy
  - We will open a branch for all new features and create pull request at the and of this feature's development
  - We will rebase commits to 1 commit for each pull request to keep main branch commit history

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Sources

- [Creating a chat application with WebRTC](https://blog.logrocket.com/creating-chat-application-with-webrtc/)

## History

- Firebase integration 14 May 2022 => https://firebase.google.com/docs/flutter/setup?platform=ios

  - Firebase core -> Usage reason and detail will be added by Serdar
  - Firebase authentication ->
  - Firestore ->
    - Rules are important to modify access level of users to data
  - Storage ->
  - Hosting ->
  - Messaging -> For push notification

- Other packages used in the project

  - [FlutterFire UI](https://pub.dev/packages/flutterfire_ui)
  - [Flutter-WebRTC](https://pub.dev/packages/flutter_webrtc)

- DevOps CI/CD for flutter using Github Actions

## Side Topics

- When using Microsoft Word for final report
  - Automatic table of contents
  - Automatic references (bibliography)
- VSCode Extensions
  - Markdown Preview Enhanced

## Need to check out

- https://pub.dev/packages/flutter_firebase_chat_core
- https://pub.dev/packages/flutterfire_ui

## Problems

- MacOS internet connection -> https://stackoverflow.com/a/61201081/6378949
- 1. Triggering Call Screen (Probably it is service api of OS)
- 2. Searching with email, name and surname
- 3. Matching system -> Messaging
- 4. ???- is WebRTC peer information changing on every matching -???
- 5. Getting peer information when the app is in background
- 6. A good looking UI
- 7. Encryption and decryption problems (especially transfer of the KEY)
