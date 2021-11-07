import 'package:flutter/material.dart';
import 'package:test_local_notification/notification_api.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  tz.initializeTimeZones();

  print(DateTime.now());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationApi.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Notification"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    NotificationApi.showNotification(
                        title: "Test",
                        body: "Pleas Keep your location on",
                        payload: "Test===>");
                  },
                  child: const Text("Simple Notification")),
              ElevatedButton(
                  onPressed: () {
                    NotificationApi.showScheduledNotification(
                        title: "Test",
                        body: "Pleas Keep your location on",
                        payload: "Test===>",
                        scheduledTime: DateTime.parse("2021-11-07 15:09:00"));
                  },
                  child: const Text("Scheduled Notification")),
              ElevatedButton(
                  onPressed: () {}, child: const Text("Remove Notification ")),
            ],
          ),
        ),
      ),
    );
  }
}
