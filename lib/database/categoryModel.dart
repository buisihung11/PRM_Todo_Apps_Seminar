// database table and column names
final String tableCategories = 'categories';
final String columnId = '_id';
final String columnName = 'name';

class Category {
  int id;
  String name;

  Category({this.id, this.name});

  // convenience constructor to create a Word object
  Category.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnName: name};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
