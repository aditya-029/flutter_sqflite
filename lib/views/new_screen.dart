import 'package:flutter/material.dart';
import 'package:flutter_sqflite/services/db_handler.dart';
import 'package:flutter_sqflite/models/notes.dart';
import 'package:flutter_sqflite/views/home_screen.dart';

class NerScreen extends StatefulWidget {
  const NerScreen({Key? key}) : super(key: key);

  @override
  State<NerScreen> createState() => _NerScreenState();
}

class _NerScreenState extends State<NerScreen> {
  var title = TextEditingController();
  var age = TextEditingController();
  var description = TextEditingController();
  var mail = TextEditingController();

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

  addedDataToSqlLite({
    required String title,
    required int age,
    required String description,
    required String email,
  }) {
    dbHelper!
        .insert(
      Notes(
        title: title,
        age: age,
        description: description,
        email: email,
      ),
    )
        .then((value) {
      debugPrint('Inserted');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
        (route) => false,
      );
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Data Entry'),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        child: Form(
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Title";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                      width: 5.0,
                    ),
                  ),
                  hintText: "Enter Title",
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: age,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Age";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                      width: 5.0,
                    ),
                  ),
                  hintText: "Enter Age",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Description";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                      width: 5.0,
                    ),
                  ),
                  hintText: "Enter Description",
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: mail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                      width: 5.0,
                    ),
                  ),
                  hintText: "Enter Email",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  addedDataToSqlLite(
                    title: title.text,
                    age: int.parse(age.text),
                    description: description.text,
                    email: mail.text,
                  );
                },
                child: const Text("Added Data to SQLLite"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
