import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key key}) : super(key: key);

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
        ),
        centerTitle: true,
      ),
      body: Container(
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
                        Row(
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
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CategoryItem(
                              icon: LineAwesomeIcons.clipboard_list,
                              category: 'All',
                              tasks: 10,
                              color: Colors.blue[600],
                            ),
                            CategoryItem(
                              icon: LineAwesomeIcons.graduation_cap,
                              category: 'Study',
                              tasks: 10,
                              color: Colors.amber,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CategoryItem(
                                icon: LineAwesomeIcons.dumbbell,
                                color: Colors.red[600],
                                category: 'Exercise'),
                            CategoryItem(
                                icon: LineAwesomeIcons.briefcase,
                                color: Colors.green[600],
                                category: 'Work'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CategoryItem(
                                icon: LineAwesomeIcons.plane_departure,
                                color: Colors.purple[600],
                                category: 'Travel'),
                            CategoryItem(
                                icon: LineAwesomeIcons.headphones,
                                color: Colors.red[600],
                                category: 'Music'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
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
