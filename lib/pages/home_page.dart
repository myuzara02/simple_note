import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/extension/date_formatter.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/services/database_services.dart';
import 'package:flutter_application_1/utils/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseSevice dbService = DatabaseSevice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Note"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(DatabaseSevice.boxName).listenable(),
        builder: (context, box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text("Tidak ada data"),
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                Note tempNote = box.getAt(index);
                return Dismissible(
                  key: Key(tempNote.key.toString()),
                  onDismissed: (_) {
                    dbService.deleteNote(tempNote).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Data ${tempNote.title} Telah Hapus"),
                        behavior: SnackBarBehavior.floating,
                      ));
                    });
                  },
                  child: NoteCard(
                    note: tempNote,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
                );
              },
              itemCount: box.length,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushNamed('add-note');
        },
        child: const Icon(
          Icons.post_add_rounded,
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 3,
      ),
      child: ListTile(
        onTap: () {
          GoRouter.of(context).pushNamed(
            AppRoutes.editNote,
            extra: note,
          );
        },
        title: Text(note.title),
        subtitle: Text(note.description),
        trailing: Text('Dibuat pada : \n ${note.createdAt.toSunda()}'),
      ),
    );
  }
}
