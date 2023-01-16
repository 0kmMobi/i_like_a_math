import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:i_like_a_math/presentation/pages/main_page.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('en'),
      Locale('ru')
    ],
    startLocale: const Locale('ru'),
    useOnlyLangCode: true,
    path: 'assets/langs',
    // assetLoader: JsonAssetLoader(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: 'Roboto'
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("deviceLocale: ${context.deviceLocale.toString()}");

    return const ScaffoldGradientBackground (
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xFFFEE356),
            Color(0xFFFEE356),
            Color(0xFFFFFFCC),
            Color(0xFFFFFFCC),
            Color(0xFFFFFF99),
            Color(0xFFFFFFCC),
            Color(0xFFFFFFCC),
            Color(0xFFFFFFCC),
          ],
        ),
      appBar: null,
      body: MainPage()
    );
  }
}
