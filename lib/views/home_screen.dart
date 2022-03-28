// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite/services/db_handler.dart';
import 'package:flutter_sqflite/views/edit_screen.dart';
import 'package:flutter_sqflite/views/add_notes.dart';

import '../models/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  late Future<List<NotesModel>> notesList;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  Future loadData() async {
    notesList = dbHelper!.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ultimate Notes'),
      ),
      body:Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: notesList,
              builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            var note = NotesModel(
                              id: snapshot.data![index].id,
                              title: snapshot.data![index].title,
                              description: snapshot.data![index].description,

                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditNotes(note: note),
                              ),
                            );
                          },
                          child: Dismissible(
                            direction: DismissDirection.endToStart,
                            background: Container(
                              child: Icon(Icons.delete_forever),
                              color: Colors.red,
                            ),
                            onDismissed: (DismissDirection direction) {
                              setState(() {
                                dbHelper!.delete(snapshot.data![index].id!);
                                notesList = dbHelper!.getNotes();
                                snapshot.data!.remove(snapshot.data![index]);
                              });
                            },
                            key: Key(snapshot.data![index].id.toString()),
                            child: ListTile(
                              title: Text(snapshot.data![index].title),
                              subtitle: Text(snapshot.data![index].description),

                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseAnalytics.instance.setCurrentScreen(
            screenName: 'NewData',
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotes(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}