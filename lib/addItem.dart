import 'package:TodoApp_Seminar_PRM/blocs/category/category_bloc.dart';
import 'package:TodoApp_Seminar_PRM/blocs/category/category_state.dart';
import 'package:TodoApp_Seminar_PRM/blocs/todo/index.dart';
import 'package:TodoApp_Seminar_PRM/database/todoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  // This widget is the root of your application.
  TextEditingController _taskController = new TextEditingController();
  TextEditingController _noteController = new TextEditingController();
  String _note = "Add note";
  final _formKey = GlobalKey<FormState>();
  String _dateTime = "Date Time";
  String _time = "Time";

  // final List<String> items = <String>['Study', 'Game', 'Work'];
  int categoryId;

  _addTodo(BuildContext context) {
    BlocProvider.of<TodosBloc>(context).add(
        TodoAdded(Todo(content: _taskController.text, categoryId: categoryId)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: const Text(
          'New task',
          style: TextStyle(color: Colors.black, fontSize: 22),
        ),
        leading: BackButton(),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadSuccess) {
              final items = state.categories;
              print(items);
              return SingleChildScrollView(
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 15, bottom: 5, right: 20, left: 20),
                      child: Text(
                        'What are you planning?',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 250.0,
                      minHeight: 250.0,
                    ),
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: new TextField(
                      controller: _taskController,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(fontSize: 26),
                    ),
                  ),
                  Divider(
                    height: 2,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 60, left: 60, bottom: 5),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      elevation: 4.0,
                      onPressed: () {},
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.dehaze,
                                        size: 18.0,
                                        color: Colors.grey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "Category",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            DropdownButton<String>(
                              hint: Text('Choose'),
                              value: categoryId != null
                                  ? items
                                      .firstWhere(
                                          (element) => element.id == categoryId,
                                          orElse: () => null)
                                      .id
                                      .toString()
                                  : null,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                              onChanged: (String newValue) {
                                setState(() {
                                  categoryId = int.parse(newValue);
                                });
                              },
                              items: items.map((category) {
                                return DropdownMenuItem<String>(
                                  child: Text('${category.name}'),
                                  value: category.id.toString(),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ]),
              );
            } else {
              return Center(child: Text("Loading Category"));
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 10),
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          height: MediaQuery.of(context).size.width / 7,
          child: const Text(
            'Create',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            BlocProvider.of<TodosBloc>(context).add(TodoAdded(Todo(
              content: _taskController.text,
              categoryId: categoryId,
              hasDone: false,
            )));
            // _addTodo(context);
          },
          color: Colors.blue,
        ),
      ),
    );
  }
}

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddItemScreen(),
    );
  }
}
