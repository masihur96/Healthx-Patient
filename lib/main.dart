import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healthx_patient/configs/app_localizations.dart';
import 'package:healthx_patient/configs/custom_theme.dart';
import 'package:healthx_patient/shared/providers/language_provider.dart';
import 'package:healthx_patient/shared/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'configs/network/connectivity_service.dart';
import 'configs/route_generator.dart';
import 'features/auth/data/services/auth_service.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/presentation/viewmodels/auth_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize connectivity service
  await ConnectivityService().initialize();
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  final themeProvider = ThemeProvider();
  final languageProvider = LanguageProvider();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // disable in release builds
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: themeProvider),
          ChangeNotifierProvider(create: (_) => languageProvider),
          ChangeNotifierProvider(
            create: (_) {
              final authService = AuthService();
              return AuthViewModel(
                LoginUseCase(authService),
                // RegisterUseCase(authService),
                authService,
              );
            },
          ),
          // ChangeNotifierProvider(create: (_) => DashboardViewModel()),
          // ChangeNotifierProvider(create: (_) => CategoryViewModel()),
          // ChangeNotifierProvider(create: (_) => AuthorViewModel()),
          // ChangeNotifierProvider(create: (_) => BookViewModel()),
          // ChangeNotifierProvider(create: (_) => BookDetailsViewModel()),
          // ChangeNotifierProvider(create: (_) => AuthorProfileViewModel()),
          // ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
          // ChangeNotifierProvider(create: (_) => CheckoutViewModel()),
          // ChangeNotifierProvider(create: (_) => MyOrderViewModel()),
          // ChangeNotifierProvider(create: (_) => MyStoryViewModel()),
          // ChangeNotifierProvider(create: (_) => ContentViewModel()),
          // ChangeNotifierProvider(create: (_) => SearchBookViewModel()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: ConnectivityService().connectivityStream,
      builder: (context, snapshot) {
        final isConnected = snapshot.data ?? true;

        return Consumer2<ThemeProvider, LanguageProvider>(
          builder: (context, themeProvider, languageProvider, child) {
            final theme = themeProvider.getTheme();

            WidgetsBinding.instance.addPostFrameCallback((_) {
              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                  statusBarColor: theme.brightness == Brightness.dark
                      ? Colors.transparent
                      : Colors.white,
                  statusBarIconBrightness: theme.brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark,
                ),
              );
            });

            return MaterialApp(
              title: 'Anuj Prakashan',
              theme: CustomTheme.lightTheme,
              darkTheme: CustomTheme.darkTheme,
              debugShowCheckedModeBanner: false,
              locale: DevicePreview.locale(context) ??
                  languageProvider.currentLocale,
              navigatorObservers: [
                // FirebaseAnalyticsObserver(
                //     analytics: FirebaseAnalytics.instance),
              ],
              builder: (context, child) {
                // ✅ Global offline banner
                return Stack(
                  children: [
                    DevicePreview.appBuilder(context, child),
                    if (!isConnected)
                      Positioned(
                        bottom: 20,
                        left: 16,
                        right: 16,
                        child: Material(
                          elevation: 6,
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.shade200,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.wifi_off,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "No internet connection",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                );
              },
              supportedLocales: const [
                Locale('en'),
                Locale('bn'),
              ],
              localizationsDelegates: const [
                AppLocalizationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: RouteGenerator.splashRoute,
            );
          },
        );
      },
    );
  }
}
