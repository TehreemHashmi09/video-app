import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'ApiServices.dart';
import 'HomeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Future.delayed(const Duration(seconds: 5));
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  runApp(
    RootRestorationScope(
      restorationId: 'root',
      child: MaterialApp(home: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class _MyAppState extends State<MyApp> with RestorationMixin {
  final RestorableString state = RestorableString('VideoScreen');
  @override
  void initState() {
    // TODO: implement initState
    if (!GetIt.I.isRegistered<ApiServices>()) {
      GetIt.I.registerLazySingleton(() => ApiServices());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'root',
      debugShowCheckedModeBanner: false,
      title: 'Video App',
      home: HomeScreen(
        restorationId: 'VideoScreen',
      ),
    );
  }

  @override
  // TODO: implement restorationId
  String get restorationId => 'VideoScreen';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // TODO: implement restoreState
    registerForRestoration(state, 'VideoScreen');
  }
}
