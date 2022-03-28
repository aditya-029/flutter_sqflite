// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/note_model.dart';

class EditNotes extends StatefulWidget {
    EditNotes({Key? key,required this.note}) : super(key: key);
 NotesModel note;
  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}