import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unilesson_admin/business/lessonManager.dart';
import 'package:unilesson_admin/ui/screens/main_screen.dart';
import 'package:unilesson_admin/ui/screens/root_screen.dart';
import 'package:unilesson_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:unilesson_admin/ui/widgets/custom_flat_button.dart';

class TrashButton extends StatefulWidget {
  String lessonID;
  TrashButton(this.lessonID) ;

  @override
  _TrashButton createState() => _TrashButton();
}

class _TrashButton extends State<TrashButton> {

   @override
  void initState() {
    super.initState();
  }
  // ···
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _blockSize = _width / 100;
    return Container(
      //margin: EdgeInsets.only(bottom:_blockSize * 2),
      child: IconButton(
        icon: Icon(Icons.delete, size: _blockSize * 7),
        color: Colors.red[500],
        onPressed: _rmv
      ));
    
  }

  Future<bool> _rmv() async {
    print(widget.lessonID);
    //LessonManager.removeLesson(widget.lessonID);
    var d = await _showDialog();
    if(d.toString() == 'true') 
    return false;
  }

  Future<bool> _showDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.0))),
            title: Text(
              'Elimina lezione',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: "OpenSans",
              ),
            ),
            content: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sei sicuro di voler eliminare la lezione? L'azione è irreversibile.",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        decoration: TextDecoration.none,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontFamily: "OpenSans",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CustomFlatButton(
                            title: "Annulla",
                            fontSize: 14,
                            textColor: Colors.black,
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            splashColor: Colors.black12,
                            borderColor: Colors.redAccent[700],
                            borderWidth: 0.5,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CustomFlatButton(
                            title: "Elimina",
                            fontSize: 14,
                            textColor: Colors.white,
                            onPressed: () async {
                              await LessonManager.removeLesson(widget.lessonID);
                              setState(() {
                                Navigator.of(context).pop(true);
                              });
                            },
                            color: Colors.redAccent[700],
                            splashColor: Colors.black12,
                            borderColor: Colors.redAccent[700],
                            borderWidth: 0.5,
                          ),
                        ],
                      ),
                    ),
                  ],
                )));
      },
    );
  }
}