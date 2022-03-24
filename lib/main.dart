/*
  Main file of app.
  Main is FCM Manager class, Material, FlutterBinding, 
  ProviderModel, route, i18n initializer.
*/
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shahjump/firebase/messaging/fcm_manager.dart';
// import 'package:shahjump/theme/theme_data.dart';
import 'package:shahjump/config/route.dart';
import 'package:shahjump/controllers/settings_and_preferences.dart';
import 'package:shahjump/localization/app_localization.dart';
// Providers
import 'package:shahjump/provider/data_collector_provider.dart';
import 'package:shahjump/provider/preferences_provider.dart';
// Screens
import 'package:shahjump/screens/splash_screen.dart';
import 'package:shahjump/screens/root_screen.dart';

// Initialize my Flutter FCM Manager
FCMManager fcm = FCMManager();
SetupPreferences setupPreferences = SetupPreferences();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Turn-on FCM Background message listener.
  FirebaseMessaging.onBackgroundMessage(fcm.firebaseMessagingBackgroundHandler);
  // Init Flutter Local Notification plug-in bar
  await fcm.flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(fcm.channel);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Set config for Android and iOS
    InitializationSettings initializationSettings = InitializationSettings(
      android: fcm.initializationAndroidSetting,
    );

    fcm.flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // Init and ready listener of FCM
    fcm.init();

    // Init settings and preferences
    setupPreferences.currentAppTheme();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return OrientationBuilder(
          builder: ((context, orientation) {
            return MultiProvider(
              providers: [
                // setup DarkThemeProvider from SetupPreferences
                ChangeNotifierProvider<DarkThemeProvider>(
                  create: (_) => setupPreferences.darkThemeProvider,
                ),
                ChangeNotifierProvider<DataCollector>(
                  create: (_) => DataCollector(),
                ),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  // theme: CustomizedTheme.defaultTheme,
                  supportedLocales: const [
                    Locale('us', 'EN'),
                    Locale('fa', 'IR'),
                  ],
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    // GlobalWidgetsLocalizations.delegate,
                  ],
                  // For set app fontSize by default size without system fontSize
                  builder: (BuildContext context, Widget? child) {
                    final MediaQueryData data = MediaQuery.of(context);
                    return MediaQuery(
                      data: data.copyWith(textScaleFactor: 1),
                      child: child!,
                    );
                  },
                  initialRoute: root,
                  routes: {
                    splashScreen: (context) => const SplashScreen(),
                    root: (context) => const RootScreen(),
                  },
                );
              }),
            );
          }),
        );
      }),
    );
  }
}
