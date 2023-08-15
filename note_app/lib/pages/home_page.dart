//import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/model/note_data.dart';
import 'package:provider/provider.dart';

import 'editing_new_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

     void initState(){
      super.initState();
      Provider.of<NoteData>(context,listen: false).initializeNotes();
     }
  
   
  ///new note ekleme işte 
      void createNewNote(){


        /// yeni id yapma 
         int id = Provider.of<NoteData>(context,listen : false).getAllNotes().length;

          //new blank note 
         Note newNote = Note(
          id:id ,
          text: '',
          );

          //go to new page
          goToNotePage(newNote ,true);
      }


      void goToNotePage(Note note ,bool isNewNote){
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditingNotePage(
          note: note,
          isNewNote: isNewNote,
        ),));
      }

      void deleteNote(Note note){
        Provider.of<NoteData>(context,listen: false).deleteNode(note);
      }



  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(builder: (context, value, child) => Scaffold(
      backgroundColor: CupertinoColors.systemBackground,
      appBar: AppBar(  
        title: Center(child: Text('Note App')),
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Colors.black,
      ),

      


      floatingActionButton: FloatingActionButton(
        onPressed:createNewNote,
        child: Icon( Icons.add,color: Colors.white,),
        elevation: 0,
        backgroundColor: Colors.grey[300],
        ),






      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child:  Text(
              'NOTES',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),
            ),
            ),

            ///notlar bundan sonraki kısmda geliyor
            
            value.getAllNotes().length == 0 ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(' hiçbir şey yok ')),
            ):CupertinoListSection.insetGrouped(
              
              children: List.generate(
                value.getAllNotes().length, (index) => CupertinoListTile(title: Text(value.getAllNotes()[index].text),
                onTap: () =>goToNotePage(value.getAllNotes()[index],false),
                trailing: IconButton(onPressed: () => deleteNote(value.getAllNotes()[index]), icon: Icon(Icons.delete)),
                )
                ),
                
            )
          
        ],
      ),

    ),);
  }
}