import 'package:flutter/material.dart';
import 'package:flutter_androssy/core.dart';

Future<void> main() async {
  runApp(AndrossyProvider(
    androssy: const Androssy(
      settings: AndrossySettings(
        locale: Locale("en"),
        theme: ThemeMode.dark,
      ),
    ),
    child: const Application(),
  ));
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return AndrossyBuilder(
      builder: (context, value) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter TDD",
          locale: value.settings.locale,
          themeMode: value.settings.theme,
        );
      },
    );
  }
}
