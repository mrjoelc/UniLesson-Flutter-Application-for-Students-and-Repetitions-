import 'package:algolia/algolia.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:unilesson_admin/business/algolia.dart';
import 'package:unilesson_admin/ui/widgets/custom_card.dart';

class SearchList extends StatefulWidget {
  final FirebaseUser user;
  SearchList(this.user);

  @override
  _SearchList createState() => new _SearchList();
}

class _SearchList extends State<SearchList> {
  Algolia algolia = Application.algolia;

  @override
  void initState() {
    super.initState();
  }

  Future<List<AlgoliaObjectSnapshot>> _getData() async {
    AlgoliaQuery query =
        algolia.instance.index('lessons').search(widget.user.uid);
    AlgoliaQuerySnapshot snap = await query.getObjects();
    List<AlgoliaObjectSnapshot> data = snap.hits;
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(212, 20, 15, 1.0),
                    ),
                  ),
                );
              } 
              else if(snapshot.data.length == 0) {
                return  Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text('Nessuna lezione presente :(', style: TextStyle(color: Colors.grey, fontSize: 20),)
                  ),
                );
              }
              else{
                return Column(
                  children: snapshot.data.map<Widget>((data) {
                    return new CustomCard(
                        lessonID: data.data["lessonID"],
                        bannerURL: data.data["bannerPictureURL"],
                        userURL: data.data["profilePictureURL"],
                        nameUser: data.data["name"] + ' ' + data.data["surname"],
                        citta: data.data["citta"],
                        regione: data.data["provincia"],
                        rank: data.data["rank"].toString());
                  }).toList(),
                );
              }
            }));
  }
}
