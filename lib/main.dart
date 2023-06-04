import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/services/database_services.dart';
import 'package:flutter_application_1/utils/app_routes.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox(DatabaseSevice.boxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Simple Note',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
      ),
      routeInformationParser: AppRoutes().goRoute.routeInformationParser,
      routeInformationProvider: AppRoutes().goRoute.routeInformationProvider,
      routerDelegate: AppRoutes().goRoute.routerDelegate,
    );
  }
}
