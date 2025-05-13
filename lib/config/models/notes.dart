class Notes {
  final int? id;
  final String? title;
  final String? description;
  final DateTime? datetime;
  final String? color;

  Notes({
    this.id,
    this.title,
    this.description,
    this.datetime,
    this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'datetime': datetime?.toIso8601String(),
      'color': color,
    };
  }

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      datetime: DateTime.parse(map['datetime']),
      color: map['color'],
    );
  }
}