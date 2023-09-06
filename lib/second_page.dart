import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quote_of_the_day/temp.dart';

import 'flutter_flow_theme.dart';
import 'package:flutter/material.dart';


class second_page extends StatefulWidget {
  const second_page({Key? key}) : super(key: key);

  @override
  _secondPage createState() => _secondPage();
}

class _secondPage extends State<second_page> {

  int currentIndex = temp().getCurrentIndex();
  late List<QueryDocumentSnapshot<Map<String,dynamic>>> quotes;
  final scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    super.initState();
  }

  T createModel<T>(BuildContext, T Function() modelBuilder) {
    return modelBuilder();
  }

  Future <void> _deleteQuote(String documentId, int index) async {
    final documentReference = FirebaseFirestore.instance
        .collection('saved').doc(documentId);

    if (index >= 0) {
      await documentReference.delete();
      deleteText();

    }
  }

  void deleteText(){
    Fluttertoast.showToast(msg: "Quote Deleted",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        textColor:Colors.black );

  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color.fromRGBO(94, 47, 180, 1.0),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),

          child: AppBar(
            shape: BeveledRectangleBorder(),
            backgroundColor: Color(0xFF35155D),
            automaticallyImplyLeading: false,
            leading: IconButton(
                alignment: AlignmentDirectional(1, 0.1),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/first_page');
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: 25,
                )
            ),

            title: Align(
              alignment: AlignmentDirectional(-0.5, 0),
              child: Text(
                'Saved Quotes',
                style: FlutterFlowTheme
                    .of(context)
                    .title1
                    .override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            actions: [],
            centerTitle: false,
            toolbarHeight: 100,
            elevation: 2,
          ),
        ),


        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('saved').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(snapshot.error.toString()));
              }
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              else {
                var quotes = snapshot.data?.docs;

                return ListView.builder(

                itemCount: (snapshot.data?.docs.length) ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  if (snapshot.data == null || snapshot.data?.docs == null) {
                    return CircularProgressIndicator();
                  }

                  Map<String,dynamic> userData = quotes?[index].data() as Map<String,
                      dynamic>;
                  String quote = userData['quote'];
                  String documentId = quotes![index].id;


                  return Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Container(
                        alignment: AlignmentDirectional.center,
                        height: 400,
                      width: 350,
                      decoration: BoxDecoration(
                      color: Color(0xFF35155D),
                      borderRadius: BorderRadius.circular(50),
                    ),

                        child: Stack(
                          children:[
                            Padding(padding: EdgeInsets.all(25) ,
                              child:Text(quote,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'cursive',
                                    fontSize: 32,
                                    color: Colors.white
                                )
                            ),),

                            Align(
                              alignment: Alignment(0, 0.9),
                              child: ElevatedButton(

                              style: ElevatedButton.styleFrom(

                                shape: CircleBorder(),
                                backgroundColor: Color(0xFF684890),
                                fixedSize: Size.fromRadius(25),

                              ),
                                onPressed:() {
                                  _deleteQuote(documentId, index);
                                },
                                child:Icon(Icons.delete),
                                )
                            )
                          ]
                        )


                  )
                  );
                }
                );
              }
            }
        ),
      );
  }
  }
