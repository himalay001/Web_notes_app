import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/helpers/show_swatch_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_web_app/models/NoteModel.dart';

class SecondPage extends StatefulWidget {
  final NotesModel? note;

  const SecondPage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController _textEditingController = TextEditingController();
  late NotesModel note;
  @override
  void initState() {
    note = widget.note ?? NotesModel();
    _textEditingController.text = widget.note?.body ?? "";
    super.initState();
  }

  void submit() async {
    if (_textEditingController.text.isNotEmpty) {
      note.body = _textEditingController.text;
      if (widget.note != null) {
       // await DatabaseProvider.db.updateNote(note);
       // await DatabaseProvider.db.updateColor(note);
      } else {
        //ADD NEW NOTE LOGIC
        note.date = DateTime.now().toIso8601String();
       // var id = await DatabaseProvider.db.addNewNote(note);
       //  print("NEW NOTE INSERTED AT ID => $id");
       //  note.id = id;
      }
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
          msg: "Text Not Found",
          fontSize: 17,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          primarySwatch: note.createMaterialColor,
          canvasColor: note.getColor,
          colorScheme: ColorScheme.dark(primary: note.createMaterialColor)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: kIsWeb ?
          Padding(
            padding: const EdgeInsets.only( top: 15, left: 16, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 40,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.only(left: 17),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                        backgroundColor: Colors.grey[900]),
                    onPressed: () => Navigator.pop(context),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 110,),
                Expanded(
                  child: Text(
                    'Notes',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.only(right: 4.8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                        backgroundColor: Colors.grey[900]),
                    onPressed: () => showMaterialSwatchPicker(
                      context: context,
                      selectedColor: note.getColor ?? Colors.black,
                      onChanged: (value) {
                        setState(() => note.color = value.value);
                      },
                    ),
                    child: Center(
                      child: Icon(
                        Icons.palette_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 55,),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                        backgroundColor: Colors.grey[900]),
                    onPressed: () => submit(),
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),)
              :
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 40,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.only(left: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                        backgroundColor: Colors.grey[900]),
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'Notes',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  width: 50,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.only(right: 4.8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9.0)),
                        backgroundColor: Colors.grey[900]),
                    onPressed: () => showMaterialSwatchPicker(
                      context: context,
                      selectedColor: note.getColor ?? Colors.black,
                      onChanged: (value) {
                        setState(() => note.color = value.value);
                      },
                    ),
                    child: Icon(
                      Icons.palette_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0)),
                      backgroundColor: Colors.grey[900]),
                  onPressed: () => submit(),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 35, left: 10.0),
          child: TextField(
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            style: TextStyle(fontSize: 20),
            cursorHeight: 25.0,
            cursorColor: Colors.grey,
            controller: _textEditingController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Write here..",
                hintStyle: TextStyle(fontSize: 21, color: Colors.grey[800])),
          ),
        ),
      ),
    );
  }
}
