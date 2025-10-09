import 'package:atomic_x/atomicx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await StorageUtil.init();
    await AppBuilder.init();

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return ComponentTheme(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LoginInfoState()),
          ChangeNotifierProvider.value(value: LocaleProvider()),
        ],
        child: Builder(builder: (context) {
          final themeState = BaseThemeProvider.of(context);
          final isDarkMode = themeState.currentType == ThemeType.dark ||
              (themeState.currentType == ThemeType.system && themeState.isSystemDarkMode);
          final localeProvider = Provider.of<LocaleProvider>(context);

          return MaterialApp(
            title: 'TUIKit Next Demo',
            localizationsDelegates: const [
              AtomicLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AtomicLocalizations.supportedLocales,
            locale: localeProvider.locale,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1C66E5)),
              primaryColor: const Color(0xFF1C66E5),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              scaffoldBackgroundColor: Colors.white,
              navigationBarTheme: NavigationBarThemeData(
                backgroundColor: Colors.white,
                indicatorColor: const Color(0xFF1C66E5).withOpacity(0.1),
                labelTextStyle: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1C66E5),
                      fontWeight: FontWeight.w500,
                    );
                  }
                  return const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  );
                }),
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF1C66E5),
                brightness: Brightness.dark,
              ),
              primaryColor: const Color(0xFF1C66E5),
              navigationBarTheme: NavigationBarThemeData(
                indicatorColor: const Color(0xFF1C66E5).withOpacity(0.3),
                labelTextStyle: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.selected)) {
                    return const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF4086FF),
                      fontWeight: FontWeight.w500,
                    );
                  }
                  return const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  );
                }),
              ),
            ),
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const LoginScreen(),
            routes: {
              '/login': (context) => const LoginScreen(),
            },
          );
        }),
      ),
    );
  }
}
