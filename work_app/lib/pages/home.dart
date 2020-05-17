import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {

  Map data = {};

  DateTime alert;

  @override
  void initState() {
    super.initState();
    alert = DateTime.now().add(Duration(seconds: 300)); // default is 5 min study time.
  }


  Text BreakText(TextStyle a) {
    // display Break notification text for ___ mins, then change reached to false.
    Future.delayed(Duration(seconds: data['breakTime']), () {
      setState(() {
        alert = DateTime.now().add(Duration(seconds: data['studyTime']));
      });
    });
    return Text(
      ((data['breakTime']/60).toInt()).toString() + ' min break!',
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }


  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
      TimerBuilder.scheduled([alert],
          builder: (context) {
            var now = DateTime.now();
            var reached = now.compareTo(alert) >= 0;
            final textStyle = Theme.of(context).textTheme.title;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    reached ? Icons.alarm_on: Icons.alarm,
                    color: reached ? Colors.redAccent: Colors.greenAccent[400],
                    size: 240,
                  ),
                  !reached ?
                  TimerBuilder.periodic(
                      Duration(seconds: 1),
                      alignment: Duration.zero,
                      builder: (context) {
                        // This function will be called every second until the time is reached.
                        var now = DateTime.now();
                        var remaining = alert.difference(now);
                        return Text(formatDuration(remaining),
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        );
                      }
                    )
                  :
                  BreakText(textStyle),

                  const SizedBox(height: 18),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: FlatButton(
                      color: Colors.greenAccent[400],
                      onPressed: () {
                        setState(() {
                          alert = DateTime.now().add(Duration(seconds: data['studyTime']));
                        });
                      },
                      child: const Text('Reset', style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: FlatButton(
                      color: Colors.redAccent,
                      onPressed: () {
                        setState(() {
                          alert = DateTime.now();
                        });
                      },
                      child: const Text('Take Break', style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 50.0,
                    child: FlatButton(
                        color: Colors.grey,
                        onPressed: () async {
                          dynamic result = await Navigator.pushNamed(context, '/settings');
                          if(result != null) {
                            setState(() {
                              data = {
                                'studyTime': result['studyTime'],
                                'breakTime': result['breakTime'],
                              };
                            });
                          }
                        },
                        child: const Text('Settings', style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )
                        )
                    ),
                  )
                ],
              ),
            );
          }
      ),
    );
  }
}

String formatDuration(Duration d) {
  String f(int n) {
    return n.toString().padLeft(2, '0');
  }
  // Need to round up the remaining time to the nearest second
  d += Duration(microseconds: 999999);
  return "${f(d.inMinutes)}:${f(d.inSeconds%60)}";
}
