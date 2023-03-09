// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to ToDo Board App! Please sign in to continue.`
  String get welcomeToToDoBoardAppPleaseSignInToContinue {
    return Intl.message(
      'Welcome to ToDo Board App! Please sign in to continue.',
      name: 'welcomeToToDoBoardAppPleaseSignInToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to ToDo Board App! Please create an account to continue`
  String get welcomeToToDoBoardAppPleaseCreateAnAccountToContinue {
    return Intl.message(
      'Welcome to ToDo Board App! Please create an account to continue',
      name: 'welcomeToToDoBoardAppPleaseCreateAnAccountToContinue',
      desc: '',
      args: [],
    );
  }

  /// `By signing in, you agree to our terms and conditions.`
  String get bySigningInYouAgreeToOurTermsAndConditions {
    return Intl.message(
      'By signing in, you agree to our terms and conditions.',
      name: 'bySigningInYouAgreeToOurTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `By registering, you agree to our terms and conditions.`
  String get byRegisteringYouAgreeToOurTermsAndConditions {
    return Intl.message(
      'By registering, you agree to our terms and conditions.',
      name: 'byRegisteringYouAgreeToOurTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `A password must have a minimum length of 8.`
  String get passwordMinimumLength {
    return Intl.message(
      'A password must have a minimum length of 8.',
      name: 'passwordMinimumLength',
      desc: '',
      args: [],
    );
  }

  /// `Passwords did not match`
  String get passwordsNotMatched {
    return Intl.message(
      'Passwords did not match',
      name: 'passwordsNotMatched',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Type a task description`
  String get typeATaskDescription {
    return Intl.message(
      'Type a task description',
      name: 'typeATaskDescription',
      desc: '',
      args: [],
    );
  }

  /// `Invalid String Value`
  String get invalidFirebaseStringValue {
    return Intl.message(
      'Invalid String Value',
      name: 'invalidFirebaseStringValue',
      desc: '',
      args: [],
    );
  }

  /// `Error Happened`
  String get genericError {
    return Intl.message(
      'Error Happened',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected Error`
  String get unexpected {
    return Intl.message(
      'Unexpected Error',
      name: 'unexpected',
      desc: '',
      args: [],
    );
  }

  /// `Failure of the Platform Server`
  String get platFormServerFailure {
    return Intl.message(
      'Failure of the Platform Server',
      name: 'platFormServerFailure',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient Permission`
  String get insufficientPermission {
    return Intl.message(
      'Insufficient Permission',
      name: 'insufficientPermission',
      desc: '',
      args: [],
    );
  }

  /// `Unable To Update`
  String get unableToUpdate {
    return Intl.message(
      'Unable To Update',
      name: 'unableToUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Task is empty please fill it first`
  String get taskIsEmptyPleaseFillItFirst {
    return Intl.message(
      'Task is empty please fill it first',
      name: 'taskIsEmptyPleaseFillItFirst',
      desc: '',
      args: [],
    );
  }

  /// `Unable to delete your task`
  String get unableToDeleteYourTask {
    return Intl.message(
      'Unable to delete your task',
      name: 'unableToDeleteYourTask',
      desc: '',
      args: [],
    );
  }

  /// `Saving`
  String get saving {
    return Intl.message(
      'Saving',
      name: 'saving',
      desc: '',
      args: [],
    );
  }

  /// `Edit the task`
  String get editTask {
    return Intl.message(
      'Edit the task',
      name: 'editTask',
      desc: '',
      args: [],
    );
  }

  /// `Create a task`
  String get createATask {
    return Intl.message(
      'Create a task',
      name: 'createATask',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Task name`
  String get taskName {
    return Intl.message(
      'Task name',
      name: 'taskName',
      desc: '',
      args: [],
    );
  }

  /// `Type your task name`
  String get typeYourTaskName {
    return Intl.message(
      'Type your task name',
      name: 'typeYourTaskName',
      desc: '',
      args: [],
    );
  }

  /// `Task description`
  String get taskDescription {
    return Intl.message(
      'Task description',
      name: 'taskDescription',
      desc: '',
      args: [],
    );
  }

  /// `Add new task`
  String get addNewTask {
    return Intl.message(
      'Add new task',
      name: 'addNewTask',
      desc: '',
      args: [],
    );
  }

  /// `No tasks yet`
  String get noTasksYet {
    return Intl.message(
      'No tasks yet',
      name: 'noTasksYet',
      desc: '',
      args: [],
    );
  }

  /// `Move to: `
  String get moveTo {
    return Intl.message(
      'Move to: ',
      name: 'moveTo',
      desc: '',
      args: [],
    );
  }

  /// `Task: `
  String get task {
    return Intl.message(
      'Task: ',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task1 {
    return Intl.message(
      'Task',
      name: 'task1',
      desc: '',
      args: [],
    );
  }

  /// `Description: `
  String get description {
    return Intl.message(
      'Description: ',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Change priority: `
  String get changePriority {
    return Intl.message(
      'Change priority: ',
      name: 'changePriority',
      desc: '',
      args: [],
    );
  }

  /// `Task created at: `
  String get createdAt {
    return Intl.message(
      'Task created at: ',
      name: 'createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Task completed at: `
  String get taskCompletedAt {
    return Intl.message(
      'Task completed at: ',
      name: 'taskCompletedAt',
      desc: '',
      args: [],
    );
  }

  /// `Select task priority: `
  String get selectTaskPriority {
    return Intl.message(
      'Select task priority: ',
      name: 'selectTaskPriority',
      desc: '',
      args: [],
    );
  }

  /// `Select task state:`
  String get selectTaskState {
    return Intl.message(
      'Select task state:',
      name: 'selectTaskState',
      desc: '',
      args: [],
    );
  }

  /// `SignOut`
  String get signOut {
    return Intl.message(
      'SignOut',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `You spent these times slots on the task : `
  String get youSpentThisTimeslotsOnTheTask {
    return Intl.message(
      'You spent these times slots on the task : ',
      name: 'youSpentThisTimeslotsOnTheTask',
      desc: '',
      args: [],
    );
  }

  /// `Task is not completed yet`
  String get taskIsNotCompletedYet {
    return Intl.message(
      'Task is not completed yet',
      name: 'taskIsNotCompletedYet',
      desc: '',
      args: [],
    );
  }

  /// `You didn't spend any time on this task yet`
  String get youDidNotSpendAnyTimeOnThisTaskYet {
    return Intl.message(
      'You didn\'t spend any time on this task yet',
      name: 'youDidNotSpendAnyTimeOnThisTaskYet',
      desc: '',
      args: [],
    );
  }

  /// `You spend: `
  String get youSpend {
    return Intl.message(
      'You spend: ',
      name: 'youSpend',
      desc: '',
      args: [],
    );
  }

  /// `  at: `
  String get at {
    return Intl.message(
      '  at: ',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `Completed task history`
  String get completedTaskHistory {
    return Intl.message(
      'Completed task history',
      name: 'completedTaskHistory',
      desc: '',
      args: [],
    );
  }

  /// `No completed tasks yet`
  String get noCompletedTasksYet {
    return Intl.message(
      'No completed tasks yet',
      name: 'noCompletedTasksYet',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task`
  String get deleteTask {
    return Intl.message(
      'Delete Task',
      name: 'deleteTask',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the task "{taskName}" with its timer history?`
  String areYouSure(Object taskName) {
    return Intl.message(
      'Are you sure you want to delete the task "$taskName" with its timer history?',
      name: 'areYouSure',
      desc: '',
      args: [taskName],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Export completed tasks data to CSV`
  String get exportToCSV {
    return Intl.message(
      'Export completed tasks data to CSV',
      name: 'exportToCSV',
      desc: '',
      args: [],
    );
  }

  /// `Export task timer history data to CSV`
  String get exportTimerHistoryToCSV {
    return Intl.message(
      'Export task timer history data to CSV',
      name: 'exportTimerHistoryToCSV',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Select the application language`
  String get selectApplicationLanguage {
    return Intl.message(
      'Select the application language',
      name: 'selectApplicationLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Welcome `
  String get welcome {
    return Intl.message(
      'Welcome ',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get userProfile {
    return Intl.message(
      'User Profile',
      name: 'userProfile',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while retrieving your profile. Please try again later!!`
  String get errorWithFetchingYourProfile {
    return Intl.message(
      'An error occurred while retrieving your profile. Please try again later!!',
      name: 'errorWithFetchingYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Account Information`
  String get accountInformation {
    return Intl.message(
      'Account Information',
      name: 'accountInformation',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message(
      'User',
      name: 'user',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
