import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();

  static BuildContext? get currentContext => navigatorKey.currentContext;

  // Basic navigation methods
  static Future<T?> pushNamed<T>({
    required String routeName,
    Object? arguments,
  }) async {
    return navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> push<T>({
    required Widget page,
    RouteSettings? settings,
  }) async {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => page, settings: settings),
    );
  }

  // Custom slide transition
  static Future<T?> pushWithSlideTransition<T>({
    required Widget page,
    RouteSettings? settings,
  }) async {
    return navigatorKey.currentState?.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: settings,
      ),
    );
  }

  // Replacement methods
  static Future<T?> pushReplacementNamed<T, TO>({
    required String routeName,
    Object? arguments,
  }) async {
    return navigatorKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushReplacement<T>({
    required Widget page,
    RouteSettings? settings,
  }) async {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => page, settings: settings),
    );
  }

  // Remove all and push new page
  static Future<T?> pushAndRemoveUntil<T>({
    required Widget page,
    bool Function(Route<dynamic>)? predicate,
    RouteSettings? settings,
  }) async {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page, settings: settings),
      predicate ?? (Route<dynamic> route) => false,
    );
  }

  // Pop methods
  static void pop<T>([T? result]) {
    return navigatorKey.currentState?.pop(result);
  }

  static void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  static Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = true,
    Color? backgroundColor,
    double? height,
  }) {
    return showModalBottomSheet(
      context: currentContext!,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor ?? const Color(0xFFD9D9D9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => SizedBox(height: height ?? 250, child: child),
    );
  }

  // Show dialog
  static Future<T?> showCustomDialog<T>({
    required String title,
    required String content,
    required List<Widget> actions,
    Color? backgroundColor,
  }) {
    return showDialog(
      context: currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          backgroundColor: backgroundColor ?? const Color(0xFFD9D9D9),
          actions: actions,
        );
      },
    );
  }

  static BuildContext get context =>
      navigatorKey.currentState!.overlay!.context;
}
