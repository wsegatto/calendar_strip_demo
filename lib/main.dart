import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

DateTime _selectedDate;
final Color _cardTextUnselectedColor = Colors.blueGrey[700];
final Color _cardColor = Colors.white;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            SizedBox(height: 16),
            Row(
              children: <Widget>[
                SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Dra. Carolina Rosa',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.tealAccent[100], fontSize: 22),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Neurologista',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.tealAccent[100], fontSize: 18),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Text(
                            'MAIS INFORMAÇÕES',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Colors.grey[100], fontSize: 12),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 30,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                  ),
                ),
                Image(
                  image: AssetImage('assets/doctor_placeholder_female.jpg'),
                  height: 90,
                  width: 90,
                ),
              ],
            ),
//            Container(
//              height: 100.0,
//              alignment: Alignment.center,
//              padding: EdgeInsets.only(bottom: 30.0),
//              color: Color(0xFF333A47),
//              child: iOSPicker(),
//            ),
            Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: androidSpecialtyDropdown()),
                Expanded(
                  child: SizedBox(width: double.infinity),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: androidPlanDropdown()),
              ],
            ),

            MyCalendarStrip(),
            //SizedBox(height: 20),
            FlatButton(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: SizedBox(
                    width: double.infinity,
                  )),
                  Icon(Icons.today, color: Colors.white, size: 20),
                  SizedBox(width: 5),
                  Text('REINICIALIZAR DATA',
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
              onPressed: () => setState(() => _resetSelectedDate()),
            ),
            Column(
              children: <Widget>[
                Padding(
                  //TODO Consultas
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(children: [
                    AppointmentCard(time: '9:00'),
                    AppointmentCard(time: '9:30'),
                    AppointmentCard(time: '11:15'),
//                    Card(
//                      color: Colors.white,
//                      elevation: 8,
//                      child: InkWell(
//                        splashColor: Colors.teal,
//                        onTap: () async {},
//                      ),
//                    )
//                    GestureDetector(
//                      onTap: () {
//                        setState(() {
//                          _cardColor = Colors.blue;
//                          print('Clicked Gesture');
//                        });
//                      },
//                      child: Card(
//                          elevation: 8.0,
//                          color: _cardColor,
//                          child: Column(
//                            mainAxisSize: MainAxisSize.min,
//                            children: <Widget>[
//                              ListTile(
//                                leading: Icon(Icons.album),
//                                title: Text('The Enchanted Nightingale'),
//                                subtitle: Text(
//                                    'Music by Julie Gable. Lyrics by Sidney Stein.'),
//                              ),
//                              ButtonBar(
//                                children: <Widget>[
//                                  FlatButton(
//                                    child: Text('BUY TICKETS'),
//                                    onPressed: () {/* ... */},
//                                  ),
//                                  FlatButton(
//                                    child: Text('LISTEN'),
//                                    onPressed: () {/* ... */},
//                                  ),
//                                ],
//                              ),
//                            ],
//                          )),
//                    ),
                  ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  String selectedSpecialty, selectedPlan;

  DropdownButton<String> androidSpecialtyDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    List<String> specialtyList = [
      'Consulta Médica',
      'Eletroencefalograma',
      'Reconsulta',
      'Tomografia',
      'Ressonância Magnética'
    ];
    //selectedSpecialty = specialtyList.elementAt(0);
    for (String specialty in specialtyList) {
      dropdownItems.add(DropdownMenuItem(
          child: Text(
            specialty,
            style: TextStyle(color: Colors.white),
          ),
          value: specialty));
    }

    return DropdownButton<String>(
      hint: Text(
        'Serviço',
        style: TextStyle(color: Colors.white),
      ),
      dropdownColor: Colors.blueGrey,
      value: selectedSpecialty,
      items: dropdownItems,
      onChanged: (value) async {
        print(value);
        setState(() {
          selectedSpecialty = value;
        });
      },
    );
  }

  DropdownButton<String> androidPlanDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    List<String> specialtyList = [
      'Unimed',
      'Ipê',
      'Omint',
      'Bradesco Seguros',
    ];
    //selectedSpecialty = specialtyList.elementAt(0);
    for (String specialty in specialtyList) {
      dropdownItems.add(DropdownMenuItem(
          child: Text(
            specialty,
            style: TextStyle(color: Colors.white),
          ),
          value: specialty));
    }

    return DropdownButton<String>(
      hint: Text(
        'Convênio',
        style: TextStyle(color: Colors.white),
      ),
      dropdownColor: Colors.blueGrey,
      value: selectedPlan,
      items: dropdownItems,
      onChanged: (value) async {
        print(value);
        setState(() {
          selectedPlan = value;
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    List<String> specialtyList = [
      'Neurologista',
      'Oftalmologista',
      'Ginecologista',
      'Reumatologista',
      'Clínico Geral'
    ];
    for (String specialty in specialtyList) {
      pickerItems.add(Text(
        specialty,
        style: TextStyle(color: Colors.white),
      ));
    }
    return CupertinoPicker(
        backgroundColor: Color(0xFF333A47),
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) async {
          selectedSpecialty = specialtyList.elementAt(selectedIndex);
          print(selectedSpecialty);
        },
        children: pickerItems);
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({@required this.time});

  final String time;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.blueGrey[100],
        elevation: 8.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: <Widget>[
            SizedBox(width: 10),
            Icon(
              FontAwesomeIcons.clinicMedical,
              color: _cardTextUnselectedColor,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Consulta Médica\n(Unimed)',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: _cardTextUnselectedColor)),
                Text('Dra. Carolina Rosa',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: _cardTextUnselectedColor)),
                Text('Av. Maurício Cardoso, 12,\nNovo Hamburgo - RS',
                    style: TextStyle(
                        fontSize: 14.0, color: _cardTextUnselectedColor)),
              ],
            ),
            Expanded(child: SizedBox(width: double.infinity)),
            Column(
              children: <Widget>[
                Icon(
                  Icons.schedule,
                  size: 40,
                  color: _cardTextUnselectedColor,
                ),
                Text(
                  time,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: _cardTextUnselectedColor),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
//                        decoration: BoxDecoration(
//                            color: Colors.white,
//                            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class MyCalendarStrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
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
    );
  }
}
