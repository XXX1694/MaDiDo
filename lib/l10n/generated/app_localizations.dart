import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('kk'),
    Locale('ru'),
  ];

  /// Title for the main tasks screen
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get myTasks;

  /// Label for the pending tasks tab
  ///
  /// In en, this message translates to:
  /// **'To Do'**
  String get toDo;

  /// Label for the completed tasks tab
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Empty state message for completed tasks tab
  ///
  /// In en, this message translates to:
  /// **'No completed tasks yet'**
  String get noCompletedTasks;

  /// Empty state message for pending tasks tab
  ///
  /// In en, this message translates to:
  /// **'You have no tasks to do'**
  String get noPendingTasks;

  /// Hint for creating a new task
  ///
  /// In en, this message translates to:
  /// **'Tap + to create a new task'**
  String get tapToCreate;

  /// Title for the new task creation screen
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get newTask;

  /// Placeholder for task title input
  ///
  /// In en, this message translates to:
  /// **'What needs to be done?'**
  String get whatNeedsToBeDone;

  /// Placeholder for task description input
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get descriptionOptional;

  /// Label for the create task button
  ///
  /// In en, this message translates to:
  /// **'Create Task'**
  String get createTask;

  /// Title for the settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Section header for general settings
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// Label for the language selection setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Section header for appearance settings
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Label for the theme selection setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Option for system theme
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Option for light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Option for dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Label for delete action
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Title for the edit task screen
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTask;

  /// Label for the save changes button
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// Name of the English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Name of the Russian language
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// Name of the Kazakh language
  ///
  /// In en, this message translates to:
  /// **'Kazakh'**
  String get kazakh;

  /// Message shown when a task is deleted
  ///
  /// In en, this message translates to:
  /// **'Task deleted'**
  String get taskDeleted;

  /// Label for undo action
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// Label for adding a deadline to a task
  ///
  /// In en, this message translates to:
  /// **'Add deadline'**
  String get addDeadline;

  /// Label for task deadline
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadline;

  /// Label for clearing all filters
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// Label for filters section
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'TaskFlow'**
  String get appTitle;

  /// Label for sorting options
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// Option for sorting by creation date
  ///
  /// In en, this message translates to:
  /// **'Date Created'**
  String get dateCreated;

  /// Option for alphabetical sorting
  ///
  /// In en, this message translates to:
  /// **'A-Z'**
  String get alphabetical;

  /// Option for sorting by priority
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// Option for sorting by category
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Title for the review dialog
  ///
  /// In en, this message translates to:
  /// **'Enjoying the app?'**
  String get reviewTitle;

  /// Description for the review dialog
  ///
  /// In en, this message translates to:
  /// **'Your feedback helps us make the app better for everyone.'**
  String get reviewDescription;

  /// Button label for positive review
  ///
  /// In en, this message translates to:
  /// **'I love it!'**
  String get reviewLoveIt;

  /// Button label for constructive feedback
  ///
  /// In en, this message translates to:
  /// **'Needs improvement'**
  String get reviewNeedsImprovement;

  /// Button label for postponing review
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get reviewLater;

  /// Message shown after submitting feedback
  ///
  /// In en, this message translates to:
  /// **'Thank you for your feedback!'**
  String get thanksForFeedback;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'kk':
      return AppLocalizationsKk();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
