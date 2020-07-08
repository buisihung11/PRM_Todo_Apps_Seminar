import 'package:TodoApp_Seminar_PRM/blocs/todo/index.dart';
import 'package:TodoApp_Seminar_PRM/blocs/todo/todo_bloc.dart';
import 'package:TodoApp_Seminar_PRM/blocs/todo/todo_state.dart';
import 'package:TodoApp_Seminar_PRM/database/databaseHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'database/categoryModel.dart';
import 'database/todoModel.dart';
// import 'package:sale_your_food/screens/home.dart';

class DetailScreen extends StatefulWidget {
  final Category category;

  const DetailScreen({Key key, this.category}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Todo> todos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // load all todo in this category
    // _loadTodo();
  }

  // _loadTodo() async {
  //   DatabaseHelper db = DatabaseHelper.db;
  //   print("Load todos in ${widget.category.id}");
  //   List<Todo> results = await db.getAllTodos(widget.category.id);
  //   for (var todo in results) {
  //     todo.categoryId = widget.category.id;
  //     print("${todo.id}: ${todo.content} ${todo.hasDone}");
  //   }
  //   setState(() {
  //     todos = results;
  //   });
  // }

  // _addTodo() async {
  //   DatabaseHelper db = DatabaseHelper.db;
  //   final todo = await db.addTodo(Todo(
  //       content: "New todo",
  //       categoryId: widget.category.id,
  //       hasDone: false,
  //       deadline: "22/01/2020"));
  //   print("Added todo ${todo.id} - ${todo.content}");
  //   await _loadTodo();
  // }

  @override
  Widget build(BuildContext context) {
    print(widget.category);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.category.name,
          style: TextStyle(
            fontFamily: 'Varela',
            fontSize: 20.0,
            color: Color(0xFF545D68),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state is TodosLoadInProgress) {
            return CircularProgressIndicator();
          } else {
            return SingleChildScrollView(
              child: TaskList(todos: (state as TodosLoadSuccess).todos),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Add new todo for ${widget.category.name}");
          // _addTodo();
          BlocProvider.of<TodosBloc>(context)
              .add(TodoAdded(Todo(content: "Hung BUi 2", hasDone: true)));
        },
        child: Icon(LineAwesomeIcons.plus),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  final List<Todo> todos;

  const TaskList({Key key, this.todos}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TextStyle _textStyle =
      TextStyle(fontFamily: 'Rubik', fontSize: 16.0, color: Colors.grey[800]);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: SingleChildScrollView(
        child: Column(
          // padding: EdgeInsets.only(left: 20.0),
          children: <Widget>[
            SizedBox(height: 15.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
              child: Row(
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: () {},
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.event_note,
                      size: 35.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                  SizedBox(width: 25.0),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 40.0, right: 30.0, top: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('All',
                            style: _textStyle.copyWith(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        SizedBox(height: 10.0),
                        Text('${widget.todos.length} tasks',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20))
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.orange[100].withOpacity(0.3),
                          offset: Offset(0.0, -10.0),
                          blurRadius: 8.0)
                    ]),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: widget.todos.length == 0
                        ? Center(child: Text("No todo in this category"))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Current:',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                  children: widget.todos
                                      .where((element) => !element.hasDone)
                                      .map((todo) => TodoItem(
                                            todo: todo,
                                          ))
                                      .toList()),
                              Text(
                                'Doned:',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                  children: widget.todos
                                      .where((element) => element.hasDone)
                                      .map((todo) => TodoItem(
                                            todo: todo,
                                          ))
                                      .toList()),
                            ],
                          ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

final TextStyle _textStyle =
    TextStyle(fontFamily: 'Rubik', fontSize: 16.0, color: Colors.grey[800]);

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({Key key, @required this.todo}) : super(key: key);

  _updateTodo(bool hasDone, BuildContext context) async {
    BlocProvider.of<TodosBloc>(context).add(
      TodoUpdated(todo.copyWith(hasDone: !todo.hasDone)),
    );
  }

  _deleteTodo(BuildContext context) {
    BlocProvider.of<TodosBloc>(context).add(TodoDeleted(todo));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                todo.content,
                style: todo.hasDone
                    ? _textStyle.copyWith(
                        // fontWeight: FontWeight.bold,
                        color: Colors.blue[200],
                        decoration: TextDecoration.lineThrough)
                    : _textStyle,
              ),
              value: todo.hasDone,
              onChanged: (bool value) {
                _updateTodo(value, context);
              },
//              secondary: const Icon(Icons.hourglass_empty),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () {
                print('Delete ${todo.id}');
                _deleteTodo(context);
              })
        ],
      ),
    );
  }
}
