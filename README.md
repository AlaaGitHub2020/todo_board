# todo_board

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

To build the project on your machine do the next steps in your project terminal :

1- Clone the code from git repository 
2- In the project termenal  run :
 - flutter clean
- flutter pub get
 - flutter packages pub run build_runner build --delete-conflicting-outputs

3- Configure your firebase project and link with the repository code:
- npm install -g firebase-tools
- dart pub global activate flutterfire_cli
- flutterfire configure

 4- After connecting with your firebase project you need to :
- enailbe the "Authentication" enable the (Sign-in providers : Email/Password ) 
- enable App Check and register your apps 
- enable Cloud Firestore 
- enable Crashlytics
- enable analytics
- enable Performance
- enable Messaging
- enable Dynamic Links 

then you can run the project on your machine.
