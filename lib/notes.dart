class Notes {
  final int? id;
  final String title;
  final int age;
  final String description;
  final String email;
  Notes(
      {this.id,
      required this.title,
      required this.age,
      required this.description,
      required this.email});

  Notes.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        age = res['age'],
        description = res['description'],
        email = res['email'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'age': age,
      'description': description,
      'email': email,
    };
  }
}
