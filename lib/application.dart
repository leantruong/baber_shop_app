import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:baber_shop_app/presentation/themes/app_theme.dart';
import 'package:flutter/material.dart';

class Application extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final String initialRoute;
  final String title;
//   final List<BlocProvider> providers;
//   final NotificationCenterService notificationService;
  final GlobalKey<NavigatorState> navigationKey;

  const Application({
    Key? key,
    this.savedThemeMode,
    required this.initialRoute,
    required this.title,
    // required this.providers,
    // required this.notificationService,
    required this.navigationKey,
  }) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildMaterialApp(
      {required Locale locale, ThemeData? light, ThemeData? dark}) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      navigatorKey: widget.navigationKey,
      theme: light,
      darkTheme: dark,
      locale: locale,
      initialRoute: widget.initialRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.getBrightTheme,
      dark: AppTheme.getDarkTheme,
      initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (ThemeData light, ThemeData dark) => _buildMaterialApp(
        locale: const Locale('vi'),
        light: light,
        dark: dark,
      ),
    );
  }
}
