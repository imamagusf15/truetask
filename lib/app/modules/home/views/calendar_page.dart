import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2035),
            onDateChanged: (value) {},
          ),
          const Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.date_range,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Text(
                "selectedDay",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) => Text("task $index"),
          )
        ],
      ),
    );
  }
}
