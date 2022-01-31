import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_web_app/models/NoteModel.dart';

class ItemCard extends StatefulWidget {
  final NotesModel note;
  final bool isSelected;
  final bool multiSelect;
  final ValueChanged<bool> isSelectedChanged;
  final VoidCallback onEdit;
  final int maxLines;

  const ItemCard({
    Key? key,
    required this.note,
    required this.isSelectedChanged,
    required this.isSelected,
    required this.onEdit,
    required this.multiSelect,
    required this.maxLines,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.isSelectedChanged(!widget.isSelected);
      },
      onTap: () {
        if (widget.multiSelect) {
          widget.isSelectedChanged(!widget.isSelected);
        } else {
          widget.onEdit();
        }
      },
      child: Stack(
        alignment: Alignment.topLeft,
        fit: StackFit.expand,
        children: [
          new Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              //  side: BorderSide(width: 0.5, color: Colors.white)
            ),
            elevation: 5.0,
            color: widget.isSelected ? Colors.blue : widget.note.getColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.note.body,
                    maxLines: widget.maxLines,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(
                      DateFormat("MMM dd, yyyy")
                          .format(DateTime.parse(widget.note.date)),
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.isSelected
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
