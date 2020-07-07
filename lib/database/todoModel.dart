// database table and column names
final String tableTodos = 'todo';
final String columnId = '_id';
final String columnContent = 'content';
final String columnHasDone = 'hasDone';
final String columnDeadline = 'deadline';
final String columnCategoryId = 'categoryId';

class Todo {
  int id;
  String content;
  bool hasDone;
  String deadline;
  int categoryId;

  Todo({this.id, this.content, this.categoryId, this.deadline, this.hasDone});

  // convenience constructor to create a Word object
  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    content = map[columnContent];
    hasDone = map[columnHasDone] == 1;
    deadline = map[columnDeadline];
    categoryId = map[columnCategoryId];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnContent: content,
      columnHasDone: hasDone ? 1 : 0,
      columnDeadline: deadline == null ? 'Default' : deadline,
      columnCategoryId: categoryId,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Todo copyWith(
      {bool hasDone,
      String id,
      String deadline,
      String content,
      int categoryId}) {
    return Todo(
      content: content ?? this.content,
      hasDone: hasDone ?? this.hasDone,
      id: id ?? this.id,
      deadline: deadline ?? this.deadline,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$id: $content $hasDone";
  }
}
