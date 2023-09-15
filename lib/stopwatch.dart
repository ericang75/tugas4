import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tugas4/countdown.dart';
import 'package:tugas4/login_screen.dart';

import 'about.dart';


class StopWatch extends StatefulWidget {
  final String name;
  final String email;

  const StopWatch({required Key key, required this.name, required this.email})
      : super(key: key);

  @override
  State createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch> {
  bool isTicking = true;
  int seconds = 0;
  late Timer timer;
  int milliseconds = 0;
  final laps = <int>[];



  void _onTick(Timer timer) {
    setState(() {
      milliseconds += 100;
    });
  }

  // String _secondsString() => seconds == 1 ? 'second' : 'seconds';
  String _secondsString(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }


  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 100), _onTick);

    setState(() {
      isTicking = true;
      laps.clear();
    });
  }

  void _stopTimer() {
    setState(() {
      timer.cancel();
      isTicking = false;
    });
  }

  void _resetTimer() {
    setState(() {
      milliseconds = 0;
    });
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      _resetTimer();
    });
  }


  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/profile": (context) => profile(),
      },
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.name),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blueAccent],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.stop_circle), text: 'Home'),
                Tab(icon: Icon(Icons.timer), text: 'Countdown'),
                Tab(icon: Icon(Icons.account_circle), text: 'About'),
              ],
            ),
          ),

            body: TabBarView(
              children: <Widget>[
                Column(
                  children: [
                  Expanded(child: buildCounter(context)),
                  Expanded(child: _buildLapDisplay()),
                  ],
                ),
                CountDown(),
                profile(),
            ],
          ),
        ),
      ),
    );
  }







  Widget buildCounter(BuildContext context) {
    return Container(
        color: Colors.lightBlueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lap ${laps.length + 1}',
              style: Theme
                  .of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.white),
            ),
            Text(
              _secondsString(milliseconds),
              style: Theme
                  .of(context)
                  .textTheme
                  .titleMedium,
            ),
            SizedBox(
                width: 20
            ),
            buildControls(),
            SizedBox(
                width: 20
            ),


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
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),

            ),
            onPressed: () => _startTimer(),
            child: Text(
                'Start'
            ),
          ),

          SizedBox(
              width: 20
          ),

          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: isTicking ? _stopTimer : null,
              child: Text(
                  'Stop'
              )
          ),

          SizedBox(
              width: 20
          ),

          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () => _lap(),
              child: Text(
                  'Lap'
              )
          )
        ]
    );
  }

  Widget _buildLapDisplay() {
    return Scrollbar(
      child: ListView.builder(
          itemCount: laps.length,
          itemBuilder: (context, index) {
            final milliseconds = laps[index];

            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 50),
              title: Text('Lap ${index + 1}'),
              trailing: Text(_secondsString(milliseconds)),
            );
          }
      ),
    );
  }
}


