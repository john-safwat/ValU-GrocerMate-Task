import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:valu_task/core/constants/constants.dart';
import 'package:valu_task/core/di/di.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';
import 'package:valu_task/core/network_utils/network_info.dart';
import 'package:valu_task/core/provider/app_config_provider.dart';
import 'package:valu_task/core/routing/app_routes.dart';
import 'package:valu_task/core/routing/routes.dart';
import 'package:valu_task/core/themeing/app_theme.dart';
import 'package:valu_task/core/utils/app_bloc_observer.dart';
import 'package:valu_task/features/products/presentation/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  Bloc.observer = AppBlocObserver();
  runApp(
    ChangeNotifierProvider.value(
      value: getIt<AppConfigProvider>()..setLocale(Constants.enLocaleKey),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppConfigProvider appConfigProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<NetworkInfo>().onConnectivityChanged.listen((connections) {
        print(connections);
        if (connections.last == ConnectivityResult.wifi ||
            connections.last == ConnectivityResult.mobile) {
          Fluttertoast.showToast(
            msg: getIt<AppConfigProvider>().localizations.youAreOnline,
          );
        } else {
          Fluttertoast.showToast(
            msg: getIt<AppConfigProvider>().localizations.youAreOffline,
          );
        }
      });
    });
  }

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
          (settings) => [MaterialPageRoute(builder: (context) => const Home())],
    );
  }
}
