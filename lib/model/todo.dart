class ToDo {
  String? id;
  String todoText;
  bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> toDoList() {
    return [
      ToDo(id: '01', todoText: "Morning Exercise", isDone: true),
      ToDo(id: '02', todoText: "Sunday Gym"),
      ToDo(id: '03', todoText: "Diet one meal a day", isDone: true),
      ToDo(id: '04', todoText: "Dinner with Anindita"),
      ToDo(id: '05', todoText: "have sex with girlfriend"),
    ];
  }
}
