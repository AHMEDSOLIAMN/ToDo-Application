import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:notes/screens/note_details.dart';
import 'package:notes/sqflite/sqflite_db.dart';

import '../constant/themes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqlDb sqlDb = SqlDb();

  readData() async {
    var response = sqlDb.readData('SELECT * FROM notes');
    return response;
  }


  TextEditingController titleController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  var formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('b3c3f4'),
        child: Icon(
          Icons.add,
          size: 25,
          color: Colors.black,
        ),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            backgroundColor: HexColor('652f90'),
            elevation: 10,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: formState,
                child: Container(
                  height: 290,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text('Add Some Notes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25)),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(),
                          child: TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.title),
                              hintText: 'Title',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: HexColor('202020'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: taskController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.note_rounded),
                            hintText: 'Note',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: HexColor('202020'),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          width: double.infinity,
                          child: MaterialButton(
                              color: HexColor('141B28'),
                              onPressed: () {
                                setState(() async {
                                  var response = await sqlDb.insertData(
                                      'INSERT INTO notes(title,task,date) VALUES("${titleController.text}","${taskController.text}","${DateFormat("MMM dd 'at' HH:mm").format(DateTime.now())}") ');
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                  titleController.clear();
                                  taskController.clear();
                                  print(response);
                                });
                              },
                              child: Text(
                                'Add Note',
                                style: TextStyle(color:Colors.white)),
                              )),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: Text(
          'Notes',
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Center(child: Text('Remove all notes')),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )),
                        TextButton(
                            onPressed: () {
                              sqlDb.deleteAllDatabase();
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              },
              icon: Icon(Icons.more_horiz_outlined)),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
            future: readData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return ConditionalBuilder(
                  condition: snapshot.data.length > 0,
                  builder: (context) => ListView.separated(
                    physics: BouncingScrollPhysics(),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 5,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Form(
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NoteDetails(
                                      editNote: snapshot.data[index]['task'],
                                      editTitle: snapshot.data[index]['title'],
                                      id: snapshot.data[index]['id'],
                                    )));
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 30,
                                                color: Colors.primaries[Random()
                                                    .nextInt(
                                                        Colors.primaries.length)],
                                              ),
                                              SizedBox(
                                                width: 6,
                                              ),
                                              if(snapshot.data[index]['title'] != null && snapshot.data[index]['title'] != '')
                                                Text(
                                                '${snapshot.data[index]['title']}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              if(snapshot.data[index]['title'] == '' )
                                                Text(
                                                'No Title',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),

                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          if(snapshot.data[index]['task'] != null && snapshot.data[index]['task'] != '' )
                                            Text(
                                            '${snapshot.data[index]['task']}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              height: 1.3,
                                            ),
                                          ),
                                          if(snapshot.data[index]['task'] == '' )
                                            Text(
                                              'No Note',
                                              style: TextStyle(
                                                color: Colors.white,
                                                height: 1.3,
                                              ),
                                            ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                '${snapshot.data[index]['date']}',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: HexColor('b0cbff'),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 10, right: 10),
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title:
                                                  Center(child: Text('Remove note')),
                                              content: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                        ),
                                                      )),
                                                  TextButton(
                                                      onPressed: () {
                                                        sqlDb.deleteData(
                                                            'DELETE FROM notes WHERE id = ${snapshot.data[index]['id']}');
                                                        setState(() {
                                                          Navigator.pop(context);
                                                        });
                                                        print('note removed ====');
                                                      },
                                                      child: Text(
                                                        'Confirm',
                                                        style: TextStyle(
                                                          color: Colors.blue,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 12,
                                          backgroundColor: HexColor('202020'),
                                          child: Icon(
                                            IconlyBroken.delete,
                                            size: 17,
                                            color: Colors.purple,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  fallback: (context) => SingleChildScrollView(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                              ),
                              Image(
                                  height: 250,
                                  image:
                                      AssetImage('assets/images/notebook.png')),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                "You don't have any notes",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('b0cbff')),
                              ),
                            ],
                          ),
                        ),
                      ));
            }),
      ),
    );
  }
}
