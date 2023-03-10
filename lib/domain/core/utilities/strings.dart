class Strings {
  static const String appTitle = "ToDo Board";

  ///Patterns (Pattern Start with p)
  static const String pEmailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  ///Assets PNG
  ///Icons (Pattern Start with ic)
  static const String icLogo = "assets/icons/ic_logo.png";
  static const String icLoading = "assets/icons/ic_loading.riv";
  static const String icAndroidLogo = "@mipmap/ic_launcher";

  ///Constants Texts (Pattern Start with c)
  static const String cUserIdForSharePreferences = "userId";
  static const String cApplicationDarkMode = "ApplicationDarkMode";
  static const String cApplicationLanguage = "ApplicationLanguage";
  static const String cUserRole = "user_role";
  static const String cSignInWithEmailAndPassword =
      "SignIn With Email And Password";
  static const String cSingUpWithEmailAndPassword =
      "SingUp_With_Email_And_Password";
  static const String cStartTaskTimer = "Start_Task_Timer";
  static const String cStopTaskTimer = "Stop_Task_Timer";
  static const String cWatchAllUserTasks = "Watch_All_User_Tasks";
  static const String cWatchUserTasksTimerHistory =
      "Watch_User_Tasks_Timer_History";
  static const String cUpdateUserTask = "Update_User_Task";
  static const String cCreateUserTaskTimerHistory =
      "Create_User_Task_Timer_History";
  static const String cId = "ID: ";
  static const String cTaskId = "Task_ID";
  static const String cTimerHistoryId = "Timer_History_ID";
  static const String cUserID = "User_ID";
  static const String cTaskID = "Task_ID";
  static const String cUpdateUser = "Update_User";
  static const String cSignOut = "Sign_Out";
  static const String cResetPassword = "Reset_Password";
  static const String cUserEmail = "User_Email";
  static const String cGetUpdatedUser = "Get_Updated_User";
  static const String cErrorHappened = "Error_Happened";
  static const String cErrorDescription = "Error_Description";
  static const String cDeleteUser = "Delete_User";
  static const String cDeleteUserTask = "Delete_User_task";
  static const String cDeleteTaskHistory = "Delete_Task_History";
  static const String cCreateUser = "Create_User";
  static const String cCreateNewUserTask = "Create_New_User_task";
  static const String cGetFCMToken = "Get_FCM_Token";
  static const String cRequestPermissions = "Request_Permissions";
  static const String cSaveFCMToken = "Save_FCM_Token";
  static const String cInitInformationDetailsForFirebaseMessaging =
      "Init_Information_Details_For_Firebase_Messaging";
  static const String cSendNotificationToSpecificUserDeviceUsingFCMToken =
      "Send_Notification_To_Specific_User_Device_Using_FCM_Token";
  static const String cSendPushMessage = "Send_Push_Message";
  static const String cFCMToken = "FCM_Token";
  static const String cCreatedAt2 = "Created_At";
  static const String cUpdatedAt = "Updated_At";
  static const String cPermissionsStatus = "Permissions_Status";
  static const String cNormalUser = "NormalUser";
  static const String cEnglishLanguageCodeSupported = "en";
  static const String cEnglishLanguageStringSupported = "English";
  static const String cArabicLanguageCodeSupported = "ar";
  static const String cArabicLanguageStringSupported = "Arabic";
  static const String cFirebaseHostingUrl =
      "https://al-asal-app.firebaseapp.com";
  static const String cAndroidMinimumVersion = '1';
  static const String cAndroidPackageName = 'com.alasal.todo_board';
  static const String cIOSBundleId = 'com.alasal.todoBoard';
  static const int cMobileWidth = 600;
  static const String cDone = "DONE";
  static const String cCompletedTasks = "Completed Tasks";
  static const String cToDo = "TODO";
  static const String cInProgress = "IN PROGRESS";
  static const String cID = "id";
  static const String cTaskName = "taskName";
  static const String cTaskDescription = "taskDescription";
  static const String cTaskState = "taskState";
  static const String cTaskPriority = "taskPriority";
  static const String cCreatedAt = "createdAt";
  static const String cTaskDateCompleted = "taskDateCompleted";
  static const String cTaskTimeSpent = "taskTimeSpent";
  static const String cTimerStopDate = "timerStopDate";
  static const String cChannelId = "todo_channel_ID";
  static const String cChannelName = "todo_channel_Name";
  static const String cNotAbleToNavigateToTheScreenFromTheNotification =
      "Not_Able_To_Navigate_To_The_Screen_From_The_Notification";
  static const String cMessageBody = "body";
  static const String cUserFCMTokensID = "UserFCMToken_For_Platform_";
  static const String cWebBrowser = "Web_Browser";
  static const String cCopyRights =
      "❤ Made With love ❤ @2023 ❤";
  static const String cServerID =
      "AAAAlHpBehM:APA91bH8RaIN2teBlfpF7PqG4X_m5AgCfyNbdqio7jmSItO_VAxUOaOcbxSiALUlTl7JYEUV5xCV8gnGaV_D2qiucO_nuAOrR9871pRrHWXR94C7mvRFBIYlSF6FtUiWdUiOshqSe18B";

  static const String cFirebaseServerApiEndPoint =
      'https://fcm.googleapis.com/fcm/send';

  static const String cApiContentType = 'Content-Type';
  static const String cApiApplicationJson = 'application/json';
  static const String cApiAuthorization = 'Authorization';
  static const String cApiKey = 'key=';
  static const String cApiPriority = 'priority';
  static const String cApiHigh = 'high';
  static const String cApiData = 'data';
  static const String cApiClickAction = 'click_action';
  static const String cApiFlutterNotificationClick =
      'FLUTTER_NOTIFICATION_CLICK';
  static const String cApiStatus = 'status';
  static const String cApiDone = 'done';
  static const String cApiBody = 'body';
  static const String cApiTitle = 'title';
  static const String cApiNotification = 'notification';
  static const String cApiAndroidChannelId = 'android_channel_id';
  static const String cApiTo = 'to';

  static List<String> settingsArrayLanguageString = [
    cEnglishLanguageStringSupported,
    cArabicLanguageStringSupported,
  ];
// static List<String> settingsArrayLanguageCodes = [
//   cEnglishLanguageCodeSupported,
//   cArabicLanguageCodeSupported,
// ];


///Constants Texts Used in Firebase DB (Pattern Start with fDB)
  static const String fDBUsers = 'users';
  static const String fDBUserTokens = 'userTokens';
  static const String fDBTasks = 'tasks';
  static const String fDBUserFCMTokens = 'userFCMTokens';
  static const String fDBTimerHistory= 'timer_history';
}

enum TaskState { toDo, inProgress, done }

enum TaskPriority { low, medium, high }
