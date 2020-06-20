import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333A47),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Calendar Timeline',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.tealAccent[100]),
              ),
            ),
            CalendarTimeline(
              initialDate: _selectedDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 180)),
              onDateSelected: (date) {
                //print(date);
                _selectedDate = date;
                print('Selected date: $_selectedDate');
              },
              leftMargin: 20,
              monthColor: Colors.white70,
              dayColor: Colors.teal[200],
              dayNameColor: Color(0xFF333A47),
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: Color(0xFF333A47),
              selectableDayPredicate: (date) {
                //return date.day != 23;
                //return date.weekday != 7;
                return true;
              },
              locale: 'en_ISO',
            ),
            SizedBox(height: 20),
            FlatButton(
              child: Text('RESET', style: TextStyle(color: Colors.white70)),
              onPressed: () => setState(() => _resetSelectedDate()),
            )
          ],
        ),
      ),
    );
  }
}
