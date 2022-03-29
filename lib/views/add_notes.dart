// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_sqflite/models/note_model.dart';
import 'package:flutter_sqflite/services/db_handler.dart';
import 'package:flutter_sqflite/views/home_screen.dart';
import 'package:flutter_sqflite/widgets/button.dart';
import 'package:flutter_sqflite/widgets/text_form_field.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  var title = TextEditingController();
  var description = TextEditingController();
  DBHelper? dbHelper;
  late Future<List<NotesModel>> notes;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  Future loadData() async {
    notes = dbHelper!.getNotes();
  }

  addNewData({title, description}) {
    dbHelper!
        .insert(
          NotesModel(
            title: title.text,
            description: description.text,
          ),
        )
        .then(
          (value) => {
            debugPrint("Inserted"),
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
              (route) => false,
            ),
          },
        )
        .onError(
          (error, stackTrace) => {
            debugPrint(error.toString()),
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Entry'),
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
              InputControllerField(icon: false,
                inputController: title,
                labelText: 'Title',
              ),
              SizedBox(height: 20),
              InputControllerField(icon: false,
                inputController: description,
                labelText: 'Description',
              ),
              const SizedBox(height: 20),
              ButtonWidget(
                buttonColor: Colors.greenAccent,
                buttonText: "Save",
                onPressed: () {
                  addNewData(title: title, description: description);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

