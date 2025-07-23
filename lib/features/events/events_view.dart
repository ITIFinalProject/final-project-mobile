import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
  preferredSize: const Size.fromHeight(70), 
  child: AppBar(
    backgroundColor: Color(0xFF1B3C53),
   
    centerTitle: false,
    title: const Padding(
      padding: EdgeInsets.only(top: 20), 
      child: Text(
        'Events',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ),
),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF456882).withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: DateTime.now(),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(Icons.chevron_left),
                    rightChevronIcon: Icon(Icons.chevron_right),
                  ),
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Color(0xFF1B3C53),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Color(0xFF1B3C53),
                      shape: BoxShape.circle,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.black54),
                    weekdayStyle: TextStyle(color: Colors.black87),
                  ),
                  availableGestures: AvailableGestures.all,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'This month',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Color(0xFF1B3C53)),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Color(0xFFF9F3EF),
                      child: const Icon(Icons.calendar_today, color: Color(0xFF1B3C53), size: 30),
                    ),
                    const SizedBox(width: 50),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No Events',
                            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF1B3C53)),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Create an event and make some memories.",
                            style: TextStyle(fontSize: 13, color: Color(0xFF456882)),
                          ),
                          
                        ],
                      ),

                    ),
                    
                  ],
                ),
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}

