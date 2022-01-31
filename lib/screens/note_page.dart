import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:notes_web_app/models/NoteModel.dart';
import 'package:notes_web_app/screens/second_page.dart';
import 'item_card.dart';

List<NotesModel> selected = [];

class Notespage extends StatefulWidget {
  Notespage({
    Key? key,
    required String title,
  }) : super(key: key);

  @override
  _NotespageState createState() => _NotespageState();
}

class _NotespageState extends State<Notespage> {
  bool isSearch = false;
  TextEditingController _textEditingController = TextEditingController();
  List<NotesModel> notes = [];
  List<NotesModel> searchedNotes = [];
  bool isLoading = true;

  @override
  initState() {
    super.initState();
  //  fetchNotesFromDb();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text('Alert !'),
            content: Text("Do you want to exit ?", style: TextStyle(fontSize: 19),),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No" , style: TextStyle(fontSize: 18, color: Colors.blue),),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Yes", style: TextStyle(fontSize: 18, color: Colors.blue),),
              ),
            ],
          ),
        )) ??
        false;
  }


  void submit() {
    Navigator.of(context).pop(_textEditingController.text);
  }
Future<void> goToSecondPage() async {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return SecondPage();
      })).then((valueFromTextField) {
        if(valueFromTextField!=null){
          String body = valueFromTextField;
            NotesModel note = NotesModel(body: body);
            note.date = DateTime.now().toIso8601String();
            try {
            //  DatabaseProvider.db.updateNote(note);
              print("note updated successfully");
            } catch (e) {
              print("ERROR====>$e");
            }
          //  fetchNotesFromDb();
            setState(() {
              
            });
        }
        print(valueFromTextField);
        
      });
    }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: isSearch
              ? Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextField(
                        style: TextStyle(fontSize: 19),
                        cursorHeight: 21.0,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Here...',
                            hintStyle: TextStyle(fontSize: 19, color: Colors.black)),
                        onChanged: (value) {
                          showSearch(value);
                        },
                      ),
                    ),
                  ),
                )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    selected.isEmpty ? "Notes" : "${selected.length}",
                    style: TextStyle(fontSize: 33),
                  ),
              ),
          actions: [
            if (selected.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 6, right: 16),
                child: Ink(
                  decoration: ShapeDecoration(
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = !isSearch;
                        searchedNotes.clear();
                      });
                    },
                    icon: Icon(isSearch ? Icons.clear : Icons.search),
                    iconSize: 30,
                    splashRadius: 3,
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 6, right: 16),
                child: Ink(
                  decoration: ShapeDecoration(
                      color: Colors.grey[900],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text('Delete'),
                                  content: Text(
                                      "Are you sure you want to delete this item?", style: TextStyle(fontSize: 17),),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: Text("Cancel", style: TextStyle(fontSize: 18.0, color: Colors.blue),),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            for (int i = 0;
                                                i < selected.length;
                                                i++) {
                                              // DatabaseProvider.db
                                              //     .deleteNote(selected[i].id);
                                            }
                                            selected.clear();
                                           // fetchNotesFromDb();
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK', style: TextStyle(fontSize: 18.0, color: Colors.blue),))
                                  ],
                                ));
                      },
                      icon: Icon(Icons.delete),splashRadius: 3,),
                ),
              ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: goToSecondPage,
          child: const Icon(
            Icons.add,
            size: 40,
            color: Colors.white,
          ),
        ),
        body: FutureBuilder<bool>(
           // future: fetchNotesFromDb(),
            builder: (context, noteData) {
              if (!noteData.hasData) {
                return Center(
                  child: Text(
                    "Press + button for add Notes",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
              return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: isSearch
                      ? searchedNotes.isNotEmpty
                          ? GridView.builder(
                              itemCount: searchedNotes.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                return GridTile(
                                  child: GestureDetector(
                                      onTap: () async {
                                        await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SecondPage(
                                                      note:
                                                          searchedNotes[index],
                                                    ))).then((value) {
                                          setState(() {
                                            // DatabaseProvider.db.updateNote(
                                            //     searchedNotes[index]);
                                            int hint = notes
                                                .indexOf(searchedNotes[index]);
                                            searchedNotes[index].body = value;
                                            notes[hint] = value;
                                          });
                                        });
                                      },
                                      child: Card(
                                        color: searchedNotes[index].getColor,
                                        elevation: 2.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                searchedNotes[index].body,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                                maxLines: 6,
                                              ),
                                              Text(
                                                DateFormat(
                                                  "MMM dd, yyyy",
                                                ).format(DateTime.parse(
                                                    searchedNotes[index].date)),
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                );
                              })
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "No notes here yet",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            )
                      : notes.isNotEmpty
                          ? SingleChildScrollView(
                              child: StaggeredGrid.count(
                                crossAxisCount: 4,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                children: notes.map((e) {
                                  final length = e.body.length + 11;
                                  int? lines =
                                      LineSplitter().convert(e.body).length;
                                  if (length > 250 || lines > 10) {
                                    return StaggeredView(
                                      mainAxisCellCount: 3.0,
                                      note: e,
                                      maxLines: 10,
                                    );
                                  }
                                  if (length > 200 || lines > 9) {
                                    return StaggeredView(
                                      mainAxisCellCount: 2.8,
                                      note: e,
                                      maxLines: 9,
                                    );
                                  }
                                  if (length > 150 || lines > 7) {
                                    return StaggeredView(
                                      mainAxisCellCount: 2.4,
                                      note: e,
                                      maxLines: 7,
                                    );
                                  }
                                  if (length > 110 || lines > 5) {
                                    return StaggeredView(
                                      mainAxisCellCount: 2.0,
                                      note: e,
                                      maxLines: 5,
                                    );
                                  }
                                  if (length > 80 || lines > 4) {
                                    return StaggeredView(
                                      mainAxisCellCount: 1.7,
                                      note: e,
                                      maxLines: 4,
                                    );
                                  }
                                  if (length > 60 || lines > 3) {
                                    return StaggeredView(
                                      mainAxisCellCount: 1.5,
                                      note: e,
                                      maxLines: 3,
                                    );
                                  }
                                  if (length > 40 || lines > 2) {
                                    return StaggeredView(
                                      mainAxisCellCount: 1.2,
                                      note: e,
                                      maxLines: 2,
                                    );
                                  } else {
                                    return StaggeredView(
                                      mainAxisCellCount: 1,
                                      note: e,
                                      maxLines: 1,
                                    );
                                  }
                                }).toList(growable: true),
                              ),
                            )
                          : Center(
                              child: Text(
                                "Press + button for add Notes",
                                style: TextStyle(fontSize: 20),
                              ),
                            ));
            }),
        backgroundColor: Colors.white12,
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomAppBar(
            color: Colors.transparent,
            shape: CircularNotchedRectangle(),
            notchMargin: 3,
            child: Row(
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                IconButton(splashRadius: 10, icon: Icon(Icons.menu, color: Colors.blueGrey, size: 30,), onPressed: () {}, ),
                SizedBox(width: 5,),
                IconButton(splashRadius:10, icon: Icon(Icons.search, color: Colors.blueGrey,size: 30, ), onPressed: () {}, ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showSearch(String query) async {
    searchedNotes = notes
        .where((element) =>
            element.body.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print(searchedNotes);
    setState(() {});
  }
}

class StaggeredView extends StatefulWidget {
  final double mainAxisCellCount;
  final int maxLines;
  final NotesModel note;

  const StaggeredView(
      {Key? key,
      required this.mainAxisCellCount,
      required this.note,
      required this.maxLines})
      : super(key: key);

  @override
  _StaggeredViewState createState() => _StaggeredViewState();
}

class _StaggeredViewState extends State<StaggeredView> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
        crossAxisCellCount: 2,
        mainAxisCellCount: widget.mainAxisCellCount,
        child: ItemCard(
          key: Key("${widget.note.id}"),
          note: widget.note,
          isSelected: selected
              .where((element) => element.id == widget.note.id)
              .isNotEmpty,
          multiSelect: selected.isNotEmpty,
          isSelectedChanged: (value) {
            setState(() {
              if (value) {
                selected.add(widget.note);
              } else {
                selected.removeWhere((element) => element.id == widget.note.id);
              }
            });
          },
          onEdit: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondPage(
                          note: widget.note,
                        ))).then((value) {
              setState(() {});
            });
          },
          maxLines: widget.maxLines,
        ));
  }
}
