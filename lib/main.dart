import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:valu_task/core/di/di.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';
import 'package:valu_task/core/provider/app_config_provider.dart';
import 'package:valu_task/core/routing/app_routes.dart';
import 'package:valu_task/core/routing/routes.dart';
import 'package:valu_task/core/themeing/app_theme.dart';
import 'package:valu_task/core/utils/app_bloc_observer.dart';
import 'package:valu_task/ui/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(
    ChangeNotifierProvider.value(
      value: getIt<AppConfigProvider>(),
      child: MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  late AppConfigProvider appConfigProvider;

  @override
  Widget build(BuildContext context) {
    appConfigProvider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: Locale(appConfigProvider.locale),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: AppRoutes.home,
      onGenerateInitialRoutes:
          (settings) => [
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ],
    );
  }
}
