import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/models/note.dart';
import 'package:flutter_application_1/services/database_services.dart';
import 'package:go_router/go_router.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({
    super.key,
    this.note,
  });

  final Note? note;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final DatabaseSevice dbServer = DatabaseSevice();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descController;
  late DateTime createdAt;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descController = TextEditingController();

    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descController.text = widget.note!.description;
    }

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note != null ? "Edit Note" : "Add Note",
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Judul wajib di isi";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Masukan Judul',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    icon: Icon(Icons.note_add),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _descController,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Deskripsi wajib di isi";
                    }
                    return null;
                  },
                  maxLines: 20,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Masukan Deskripsi',
                    labelStyle: TextStyle(
                      fontSize: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Note tempNote = Note(
              _titleController.text,
              _descController.text,
              DateTime.now(),
            );
            if (widget.note != null) {
              await dbServer.editNote(widget.note!.key, tempNote);
            } else {
              await dbServer.addNote(tempNote);
            }
            if (!mounted) return;
            GoRouter.of(context).pop();
          }
        },
        label: const Text('Simpan'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
