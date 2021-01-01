import 'package:intl/intl.dart';
import 'services.dart';
import 'db.dart';
import 'models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Global {
  //Data Models
  static final Map models = {
    //stub
  };

  static final Collection<Schedule> scheduleRef =
      Collection<Schedule>(path: 'Shifts');
  static final UserData<Shift> shiftRef =
      UserData<Shift>(collection: 'reports');
}

int weekNumber(DateTime date) {
  int dayOfYear = int.parse(DateFormat("D").format(date));
  return ((dayOfYear - date.weekday + 10) / 7).floor();
}

int currentWeek() {
  var now = new DateTime.now();
  return weekNumber(now);
}

int currentTime() {
  var now = new DateTime.now();
  var time = (now.hour * 100) + now.minute;
  return time;
}

var currentStoreID = "1182";
int currentDay() {
  var now = new DateTime.now();
  return now.weekday;
}

String currentYear() {
  var now = new DateTime.now();
  return now.year.toString();
}

var dayMap = {
  1: 'Monday',
  2: 'Tusday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday'
};
User user = AuthService().getUser;
Future<String> getWeekDoc({int futureWeek = 0}) async {
  QuerySnapshot querySnapshot = await db
      .collection('Schedule')
      .where('StoreID', isEqualTo: currentStoreID)
      .where('WeekCode', isEqualTo: currentWeek() + futureWeek)
      .where('YearCode', isEqualTo: currentYear)
      .get();

  if (querySnapshot.size == 1) {
    return querySnapshot.docs.first.id;
  } else {
    return 'Error';
  }
}
