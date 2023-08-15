import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app/model/note.dart';

class HiveDatabase {
  ///referance final box 
  final _myBox = Hive.box('note_database');

  ////load notes
  List<Note>loadNotes(){
    List<Note> savedNotesFormatted = [];
    //if there exist note 
    if (_myBox.get('ALL_NOTES') != null) {
      List<dynamic>savedNotes = _myBox.get('ALL_NOTES');
      for (int i = 0 ; i < savedNotes.length ; i++){
        Note individualNote = Note(id: savedNotes[i][0], text: savedNotes[i][1]);
        
        savedNotesFormatted.add(individualNote);

      }

    }
    else{
      savedNotesFormatted.add(
        Note(id: 0, text: 'first note'),
      );
    }

    return savedNotesFormatted;
  }

  void savedNotes(List<Note> allNotes){
    List<List<dynamic>> allNotesFormated = [

    ];

    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormated.add([id,text]);

    }

    _myBox.put('ALL_NOTES', allNotesFormated);
  }
   
}