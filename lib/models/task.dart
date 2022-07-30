class Task {
  String IDtag;
  DateTime dateAcquired;
  bool Service;
  String Manufacturer;
  double weigth;


  Task({
    required this.IDtag,
    required this.dateAcquired,
    required this.Service,
  required this.Manufacturer,
  required this.weigth,
  });

  factory Task.fromMap(Map task) {
    return Task(
      IDtag: task["IDtag"],
      dateAcquired: task["dateAcquired"],
      Service: task["Service"],
      Manufacturer: task['Manufacturer'],
      weigth: task['weight']
    );
  }

  Map toMap() {
    return {
      "IDtag": IDtag,
      "dateAcquired": dateAcquired,
      "Service": Service,
      'weight': weigth,
      'Manufacturer': Manufacturer,
    };
  }
}
