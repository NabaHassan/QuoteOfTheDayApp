import 'package:flutter/material.dart';
import 'package:quote_of_the_day/first_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quote_of_the_day/second_page.dart';
import 'package:quote_of_the_day/temp.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final SharedPreferences prefs = await SharedPreferences.getInstance();


    int counterIndex = (prefs.getInt('counterIndex') ?? 0) + 1;
    if(counterIndex == 11){
      counterIndex = 0;
    };

  await prefs.setInt('counterIndex', counterIndex);


  runApp(MaterialApp(
    title: "Quote Of The Day",
    initialRoute: '/first_page',
    debugShowCheckedModeBanner: false,
    routes: {
      '/second_page': (context) => second_page(),
      '/first_page': (context) => first_page(),
    },
    onUnknownRoute: (RouteSettings settings) {
      return MaterialPageRoute(
        builder: (context) => NotFoundPage(),
      );
    },
  ));
}
class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text(
          "Page Not Found"
        ),
      ),
    );
  }
}


