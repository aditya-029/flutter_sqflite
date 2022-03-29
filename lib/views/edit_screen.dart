// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/note_model.dart';
import 'package:flutter_sqflite/services/db_handler.dart';
import 'package:flutter_sqflite/views/home_screen.dart';
import 'package:flutter_sqflite/widgets/button.dart';
import 'package:flutter_sqflite/widgets/text_form_field.dart';

class EditNotes extends StatefulWidget {
  EditNotes({
    Key? key,
    required this.note,
  }) : super(key: key);
  NotesModel note;
  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  DBHelper? dbHelper;
  late Future<List<NotesModel>> notesList;
  Future loadData() async {
    notesList = dbHelper!.getNotes();
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
    title.text = widget.note.title;
    description.text = widget.note.description;
  }

  var title = TextEditingController();
  var description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Notes'),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          child: ListView(
            shrinkWrap: true,
            children: [
              InputControllerField(
                  inputController: title, icon: true, labelText: 'Title'),
              InputControllerField(
                  icon: true,
                  inputController: description,
                  labelText: 'Description'),
              ButtonWidget(
                buttonText: 'Update ',
                buttonColor: Colors.redAccent,
                onPressed: () async {
                  dbHelper!
                      .update(NotesModel(
                        id: widget.note.id,
                        title: title.text,
                        description: description.text,
                      ))
                      .then((value) => {
                            debugPrint("Updated"),
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HomeScreen(),
                              ),
                              (route) => false,
                            ),
                          })
                      .onError((error, stackTrace) => {
                            debugPrint(
                              error.toString(),
                            ),
                          });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
