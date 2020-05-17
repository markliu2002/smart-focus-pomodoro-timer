import 'package:flutter/material.dart';
import 'package:workapp/services/time.dart';



class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}



class _SettingsState extends State<Settings> {

  List<Time> times = [
  Time(studyTime: 300, breakTime: 60), // 5 min study, 1 min break
  Time(studyTime: 600, breakTime: 120), // 10 min study, 2 min break
  Time(studyTime: 900, breakTime: 180), // 15 min study, 3 min break
  Time(studyTime: 1200, breakTime: 240), // 20 min study, 4 min break
  Time(studyTime: 1500, breakTime: 300), // 25 min study, 5 min break
  Time(studyTime: 1800, breakTime: 360), // 30 min study, 6 min break
  Time(studyTime: 2100, breakTime: 420), // 35 min study, 7 min break
  Time(studyTime: 2400, breakTime: 480), // 40 min study, 8 min break
  Time(studyTime: 2700, breakTime: 540), // 45 min study, 9 min break
  Time(studyTime: 3000, breakTime: 600), // 50 min study, 10 min break
  Time(studyTime: 3300, breakTime: 660), // 55 min study, 11 min break
  Time(studyTime: 3600, breakTime: 720), // 60 min study, 12 min break
  ];


  void updateTime(index) async {

    Time instance = times[index];
    await instance.getTime();

    Navigator.pop(context, {
      'studyTime': instance.studyTime,
      'breakTime': instance.breakTime,
    });
  }


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Customize Cycle:'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: times.length,
          itemBuilder: (context, index) {

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text('Study: ' + ((times[index].studyTime/60).toInt()).toString() + ' mins                  Break: ' + ((times[index].breakTime/60).toInt()).toString() + ' mins',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
              ),
            );
          }
        ),
    );
  }
}
