import 'package:TodoApp_Seminar_PRM/addItem.dart';
import 'package:TodoApp_Seminar_PRM/blocs/category/category_bloc.dart';
import 'package:TodoApp_Seminar_PRM/blocs/category/category_state.dart';
import 'package:TodoApp_Seminar_PRM/blocs/todo/todo_bloc.dart';
import 'package:TodoApp_Seminar_PRM/blocs/todo/todo_event.dart';
import 'package:TodoApp_Seminar_PRM/blocs/todo/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'detail.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: IconButton(
          icon: Icon(
            LineAwesomeIcons.bars,
            size: 35,
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadInProgress) {
            return Text(
              'Loading Category...',
              style: TextStyle(
                color: Colors.lightBlueAccent,
              ),
            );
          } else {
            final categories = (state as CategoryLoadSuccess).categories;
            return Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20, bottom: 10),
                                child: Text(
                                  'Categories',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 28,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              categories.length == 0
                                  ? Text('No Category')
                                  : Expanded(
                                      child: GridView.count(
                                        crossAxisCount: 2,
                                        children: categories
                                            .map((c) => InkWell(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          BlocProvider(
                                                        create: (context) =>
                                                            TodosBloc(
                                                                categoryId:
                                                                    c.id)
                                                              ..add(
                                                                LoadTodo(),
                                                              ),
                                                        child: DetailScreen(
                                                          category: c,
                                                        ),
                                                      ),
                                                    ));
                                                  },
                                                  child: CategoryItem(
                                                    category: c.name,
                                                    icon: LineAwesomeIcons
                                                        .plane_departure,
                                                    color: Colors.blueAccent,
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddItemScreen(),
            ),
          );
        },
        child: Icon(LineAwesomeIcons.plus),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final category;
  final int tasks;
  final Color color;

  const CategoryItem({
    Key key,
    this.icon,
    this.category,
    this.tasks = 0,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 50,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey[100]),
              bottom: BorderSide(color: Colors.grey[100]),
              left: BorderSide(color: Colors.grey[100]),
              right: BorderSide(color: Colors.grey[100])),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 5, 5, .2),
              blurRadius: 20,
              offset: Offset(0, 7),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Icon(
                  this.icon,
                  size: 40,
                  color: this.color,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                this.category,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                this.tasks.toString() + " Tasks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
