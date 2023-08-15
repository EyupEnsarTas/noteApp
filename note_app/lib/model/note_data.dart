import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/data/hive_database.dart';
import 'package:note_app/model/note.dart';

class NoteData extends ChangeNotifier{


   //hive database
   final db = HiveDatabase();


  //overall list of notes //notları burda yazıcaz gülüm



  List<Note> allNotes = [
    //default first note // başlangıç notu ilk  olarak 
    Note(id: 0, text: 'ilk Not'),
  ];

  ///
  
  void initializeNotes() {
    allNotes = db.loadNotes();
  }


  ///
  


  //get notes // diğer notları getirme kısmı 
  List<Note> getAllNotes(){
    return allNotes;
  }

  //add new notes //yeni not ekliyoz aga bu kısımda 
  void addNewNote(Note note){
    allNotes.add(note);
    notifyListeners();
  }

  //update note
  void updateNote(Note note, String text){
    //go thru list of all notes //tüm notların listesine git 
    for (int i = 0; i < allNotes.length; i++) {
      //find te relevant note //istenilen notu bulma 
      if (allNotes[i].id == note.id) {
        //replace text
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  void deleteNode(Note note){
    allNotes.remove(note);
  }

}