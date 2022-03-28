// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite/services/db_handler.dart';
import 'package:flutter_sqflite/models/notes.dart';
import 'package:flutter_sqflite/views/new_screen.dart';
import 'package:flutter_sqflite/views/view_notes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper;
  late Future<List<Notes>> notesList;
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
        title: const Text('Flutter Sqflite Demo'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: notesList,
              builder: (context, AsyncSnapshot<List<Notes>> snapshot) {
                if (snapshot.hasData) {
                  return Card(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            var note = Notes(
                              id: snapshot.data![index].id,
                              title: snapshot.data![index].title,
                              age: snapshot.data![index].age,
                              description: snapshot.data![index].description,
                              email: snapshot.data![index].email,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ViewNotes(note: note),
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
                              trailing:
                                  Text(snapshot.data![index].age.toString()),
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
              builder: (context) => NerScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}