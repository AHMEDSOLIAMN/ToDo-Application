import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/sqflite/sqflite_db.dart';

class NoteDetails extends StatefulWidget {
  final editNote ;
  final editTitle ;
  final id ;
   NoteDetails({Key? key, this.editNote, this.editTitle, this.id}) : super(key: key);

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {

  SqlDb sqlDb = SqlDb();
   var editNoteController = TextEditingController();
   var editTitleController = TextEditingController();

   var formState = GlobalKey<FormState>();
  @override
  void initState() {
    editNoteController.text = widget.editNote;
    editNoteController.text = widget.editTitle;
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Note Details',
          style: TextStyle(
            color: HexColor('b0cbff'),
          ),
        ),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Card(
              color: HexColor('2e3e5b'),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Text(' Title : ${widget.editTitle}',style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),),
                    SizedBox(height: 5,),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 5,),
                    Text(' Note : ${widget.editNote}',style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
