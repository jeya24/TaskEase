class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'NSCC', isDone: true),
      ToDo(id: '02', todoText: 'COA', isDone: true),
      ToDo(
        id: '03',
        todoText: 'Meeting',
      ),
      ToDo(
        id: '04',
        todoText: 'Groceries',
      ),
      ToDo(
        id: '05',
        todoText: 'Call Dad',
      ),
    ];
  }
}
