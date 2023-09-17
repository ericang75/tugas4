import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class CountDown extends StatefulWidget {

  @override
  State createState() => CountDownState();
}

class CountDownState extends State<CountDown> {
  int seconds = 10;
  late Timer timer;
  bool isTicking = true;

  @override
  void initState() {
    super.initState();
    _startCount();
  }

  String _secondsString(int seconds) {
    return '$seconds seconds';
  }

  void _addTimer() {
    setState(() {
      seconds = seconds + 10;
    });
  }

  void _startCount() {
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {

          if (seconds > 0) {
            seconds--;
          } else {
            timer.cancel();
          }
            if (seconds == 0) {
              _notification();
            }
        });
      });
  }

  void _stopCount() {
    setState(() {
      timer.cancel();
      isTicking = false;
      });
    }

  void _notification() {
    if (seconds == 0) {
      Fluttertoast.showToast(
        msg: 'Waktu telah habis',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    _notification();
    return Scaffold(
      body: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTimer(context),

        ]
      )
    );
  }

  Widget buildTimer(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.black54
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 225),
          Text(
            _secondsString(seconds),
            style: Theme.of(context).textTheme.headline5?.copyWith(color:Colors.white),
          ),
            SizedBox(height: 20),
            buildControls(),
            SizedBox(height: 208),
        ],
      )
    );
  }

  Row buildControls() {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
          onPressed: () => _startCount(),
          child: Text(
              'Start',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
        ),
      ),
      SizedBox(width: 50),
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
        ),
        onPressed: () => _addTimer(),
        child: Text(
            'Add',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),

      SizedBox(width: 50),
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white70),
        ),
        onPressed: () => _stopCount(),
        child: Text(
            'Stop',
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),


    ],


  );


  }
}



