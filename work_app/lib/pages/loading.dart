import 'package:flutter/material.dart';
import 'package:workapp/services/time.dart';



class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}



class _LoadingState extends State<Loading> {

  void setupTime() async {
    Time instance = Time(studyTime: 300, breakTime: 60); // Default is 5 min study, 1 min break
    await instance.getTime();

    // This is the information we need to pass to the Settings screen.
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'studyTime': instance.studyTime,
      'breakTime': instance.breakTime
    });
  }

  @override
  void initState() {
    super.initState();
    setupTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text('LOADING SCREEN'),
        ],
      ),
    );
  }


}
