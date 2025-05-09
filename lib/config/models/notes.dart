class Notes {
  final int? id;
  final String? title;
  final String? description;
  final String? date;
  final String? color;

  Notes({
    this.id,
    this.title,
    this.description,
    this.date,
    this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'color': color,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      color: map['color'],
    );
  }
}