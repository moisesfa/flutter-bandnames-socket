class Band {
  String id;
  String name;
  int votes;

  Band({this.id, this.name, this.votes});

  // factory constructor para regresar una nueva instacia de mi banda
  factory Band.fromMap(Map<String, dynamic> obj) =>
      Band(id: obj['id'], name: obj['name'], votes: obj['votes']);
}
