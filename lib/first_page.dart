import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quote_of_the_day/temp.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow_theme.dart';
import 'flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_animate/flutter_animate.dart';


class first_page extends StatefulWidget {


  @override
  _firstPage createState() => _firstPage();
}

class _firstPage extends State<first_page> {

  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
  }

  temp Temp = temp();

  Future <void> saveQuote(data) async{
    await FirebaseFirestore.instance.collection('saved').add({'quote':data,});

  }


   void shareQuote(String quote){
    Share.share(quote);
  }

  void saveText(){
    Fluttertoast.showToast(msg: "Quote Saved",
    gravity: ToastGravity.BOTTOM,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.white,
        textColor:Colors.black );

  }

  T createModel<T>(BuildContext, T Function() modelBuilder) {
    return modelBuilder();
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
            title: Align(
              alignment: AlignmentDirectional(0, 0),
              child: Text(
                'Quote Of The Day',
                style: FlutterFlowTheme.of(context).title1.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            actions: [],
            centerTitle: true,
            toolbarHeight: 100,
            elevation: 10,
          ),
        ),
          body: Stack(
            children:[
              FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle errors
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final SharedPreferences prefs = snapshot.data!;
                    int counterIndex = prefs.getInt('counterIndex') ?? 0;
                    Temp.setCurrentIndex(counterIndex);
                    return Text('');

                  }
                },
              ),
              StreamBuilder<QuerySnapshot>(

                  stream: FirebaseFirestore.instance.collection('quotes').snapshots(),
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
                      Map<String,dynamic>  userData = quotes?[Temp.getCurrentIndex()].data() as Map<String, dynamic>;
                      String quote = userData['quote'];


                      return Column(
                        children: [
                          SafeArea(
                              top: true,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Text(
                                        'Today\'s Quote',
                                        style: FlutterFlowTheme
                                            .of(context)
                                            .title2
                                            .override(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),

                                              child:Container(
                                                padding: EdgeInsets.all(30),
                                                width: 350,
                                                height: 430,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF35155D),
                                                  borderRadius: BorderRadius.circular(50),

                                                ),
                                                child: Stack(
                                                  children: [
                                                    Animate(
                                                      effects: [FlipEffect(delay: 30.ms),],
                                                      child:Text(quote,
                                                        style: TextStyle(
                                                          fontFamily: 'cursive',
                                                          color: Colors.white,
                                                          fontSize: 32,
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                        alignment: AlignmentDirectional.bottomCenter,
                                                        child:ElevatedButton(
                                                            onPressed:() {saveQuote(quote);
                                                            saveText();
                                                            },
                                                            style: ElevatedButton.styleFrom(
                                                              backgroundColor: Color(0xFF684890),
                                                              shape: CircleBorder(),
                                                              fixedSize: Size.fromRadius(25),
                                                            ),
                                                            child: Animate(
                                                              child: Icon(
                                                                  Icons.favorite
                                                              ),
                                                              effects: [RotateEffect(delay: 30.ms)],
                                                            )

                                                        )
                                                    )
                                                  ],
                                                )

                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(0, 1),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                                child: FFButtonWidget(
                                                  onPressed: () {shareQuote(quote + " QuoteOfTheDay ");
                                                  },
                                                  text: 'Share',
                                                  icon: Icon(
                                                    Icons.share,
                                                    size: 15,
                                                  ),
                                                  options: FFButtonOptions(
                                                    height: 40,
                                                    padding:
                                                    EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                    iconPadding:
                                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                    color: Color(0xFF684890),
                                                    textStyle: FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1
                                                        .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                    ),
                                                    elevation: 3,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                                                child: FFButtonWidget(
                                                  onPressed: () {
                                                    Navigator.popAndPushNamed(context, '/second_page');
                                                  },
                                                  text: 'Saved',
                                                  icon: Icon(
                                                    Icons.storage,
                                                    size: 15,
                                                  ),
                                                  options: FFButtonOptions(
                                                    height: 40,
                                                    padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                                                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                    color: Color(0xFF684890),
                                                    textStyle: FlutterFlowTheme
                                                        .of(context)
                                                        .bodyText1

                                                        .override(
                                                      fontFamily: 'Readex Pro',
                                                      color: Colors.white,
                                                    ),
                                                    elevation: 3,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],


                                  )
                                ],
                              )
                          )
                        ],
                      );

                    }

                  }
              ),

            ]

          )


    );
  }
}
