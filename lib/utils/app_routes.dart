import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/add_note_pages.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:go_router/go_router.dart';

import '../models/note.dart';

class AppRoutes {
  static String home = "home";
  static String addNote = "add-note";
  static String editNote = "edit-note";

  static Page homePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MaterialPage(
      child: HomePage(),
    );
  }

  static Page AddNotePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MaterialPage(
      child: AddNotePage(),
    );
  }

  static Page EditNotePageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return MaterialPage(
      child: AddNotePage(
        note: state.extra as Note,
      ),
    );
  }

  final GoRouter goRoute = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: home,
        pageBuilder: homePageBuilder,
        routes: [
          GoRoute(
            name: addNote,
            path: 'add-note',
            pageBuilder: AddNotePageBuilder,
          ),
          GoRoute(
            name: editNote,
            path: 'edit-note',
            pageBuilder: EditNotePageBuilder,
          ),
        ],
      ),
    ],
  );
}
