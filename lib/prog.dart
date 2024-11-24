import 'package:flutter/material.dart';

void main() {
  runApp(PalwashaApp());
}

class PalwashaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palwasha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _remainingTime = 10;
  bool _isRunning = false;

  void _startTimer() async {
    if (_isRunning) return;
    setState(() {
      _isRunning = true;
      _remainingTime = 10;
    });

    while (_remainingTime > 0) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _remainingTime--;
      });
    }

    setState(() {
      _isRunning = false;
    });

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Time's Up!"),
          content: Text("The countdown has finished."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Palwasha'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Time Remaining:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '$_remainingTime',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _startTimer,
              child: Text(_isRunning ? 'Running...' : 'Start Timer'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
