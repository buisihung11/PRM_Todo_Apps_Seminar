// database table and column names
final String tableTodos = 'todos';
final String columnId = '_id';
final String columnContent = 'content';
final String columnHasDone = 'hasDone';
final String columnDeadline = 'deadline';

class Todo {
  int id;
  String content;
  bool hasDone;
  String deadline;

  Todo();

  // convenience constructor to create a Word object
  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    content = map[columnContent];
    hasDone = map[hasDone];
    deadline = map[deadline];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnContent: content,
      columnHasDone: hasDone,
      columnDeadline: deadline
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
