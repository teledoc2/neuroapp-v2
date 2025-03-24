import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:your_app/providers/app_provider.dart';
import 'package:your_app/screens/home_screen.dart';
import 'package:your_app/screens/second_screen.dart';
import 'package:your_app/utils/app_localizations.dart';
import 'package:your_app/utils/error_logger.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFF32373C),
  primarySwatch: MaterialColor(
    0xFF32373C,
    {
      50: Color(0xFFE3E4E5),
      100: Color(0xFFB8BABC),
      200: Color(0xFF8A8D90),
      300: Color(0xFF5C5F63),
      400: Color(0xFF3C4044),
      500: Color(0xFF32373C),
      600: Color(0xFF2C3135),
      700: Color(0xFF24282C),
      800: Color(0xFF1C2023),
      900: Color(0xFF121416),
    },
  ),
  accentColor: Color(0xFFF78DA7),
  scaffoldBackgroundColor: Color(0xFFF5F5F5),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    ErrorLogger.log(details.exceptionAsString(), details.stack);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/second': (context) => SecondScreen(),
        },
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: child,
          );
        },
      ),
    );
  }
}
