import 'package:flutter/material.dart';
import 'package:valu_task/core/l10n/translation/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: OutlinedButton(onPressed: () {},
            child: Text(AppLocalizations.of(context)!.appName)),
      ),
    );
  }
}
