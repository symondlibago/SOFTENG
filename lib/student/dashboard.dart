import 'package:first_project/backend.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime today = DateTime.now();


  List<dynamic> userDeets = [];


  
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi, Trailblazer'),
      ),
      drawer: SidebarDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Existing TableCalendar
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF1f1b4f),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: TableCalendar(
                locale: 'en_us',
                rowHeight: 35,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    color: Color.fromRGBO(250, 180, 23, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle:
                      TextStyle(color: Color.fromRGBO(250, 180, 23, 1)),
                  weekendStyle:
                      TextStyle(color: Color.fromRGBO(250, 180, 23, 1)),
                ),
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(250, 180, 23, 1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${date.day}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  todayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    child: Text(
                      '${date.day}',
                      style: TextStyle(color: Color.fromRGBO(250, 180, 23, 1)),
                    ),
                  ),
                ),
                focusedDay: today,
                onDaySelected: _onDaySelected,
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                firstDay: DateTime.utc(2024, 01, 01),
                lastDay: DateTime.utc(2025, 01, 01),
              ),
            ),

            SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.0), //
              decoration: BoxDecoration(
                color: Color(0xFF1f1b4f),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                '${_formattedDate(today)}',
                style: TextStyle(
                  color: Color.fromRGBO(250, 180, 23, 1),
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formattedDate(DateTime date) {
    return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
  }

  String _getMonthName(int month) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}

bool isSameDay(DateTime dayA, DateTime dayB) {
  return dayA.year == dayB.year &&
      dayA.month == dayB.month &&
      dayA.day == dayB.day;
}
