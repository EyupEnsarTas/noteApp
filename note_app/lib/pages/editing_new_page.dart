import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_app/model/note_data.dart';
import 'package:provider/provider.dart';

import '../model/note.dart';

class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;
  EditingNotePage({
    super.key,
    required this.note,
    required this.isNewNote,
  });

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  //load existing note
  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: TextSelection.collapsed(offset: 0));
    });
  }

  //add new note

  void addNewNote() {
    //get int id
    int id = Provider.of<NoteData>(context, listen:false).getAllNotes().length;
    //get from editor
    String text = _controller.document.toPlainText();
    //add the new note
    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note(id: id, text: text));
  }

  //updating existing note
  void updateNote() {
    String text = _controller.document.toPlainText();

    /// update note
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote( );
            }
            else{
              updateNote();
            }

            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),  
          color: Colors.black,
          ),
      
      ),
      body: Column(
        children: [
          //toolbar
          QuillToolbar.basic(
            controller: _controller,
            showAlignmentButtons: false,
            showBackgroundColorButton: false,
            showCenterAlignment: false,
            showColorButton: false,
            showCodeBlock: false,
            showDirection: false,
            showFontFamily: false,
            showDividers: false,
            showIndent: false,
            showHeaderStyle: false,
            showLink: false,
            showSearchButton: false,
            showInlineCode: false,
            showQuote: false,
            showListNumbers: false,
            showListBullets: false,
            showClearFormat: false,
            showBoldButton: false,
            showFontSize: false,
            showItalicButton: false,
            showUnderLineButton: false,
            showStrikeThrough: false,
            showListCheck: false,
            showJustifyAlignment: false,
            showSuperscript: false,
            showSubscript: false,
          ),


          Expanded(child: Container(padding: EdgeInsets.all(20),
          child: QuillEditor.basic(controller: _controller, readOnly: false),))

          //editor
        ],
      ),
    );
  }
}
