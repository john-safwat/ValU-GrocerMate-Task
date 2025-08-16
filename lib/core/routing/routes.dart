import 'package:flutter/material.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';
import 'package:valu_task/core/routing/app_routes.dart';
import 'package:valu_task/ui/home_screen.dart';

abstract class Routes {
  static Route generateRoute(RouteSettings settings) {
    final url = Uri.parse(settings.name ?? "/");

    switch (url.path) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Row(),
                    Text(AppLocalizations.of(context)!.appName),
                  ],
                ),
              ),
        );
    }
  }
}
