import 'package:rxdart/rxdart.dart';

import 'services.dart';
import 'db.dart';
import 'models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Global {
  //Data Models
  static final Map models = {
    //stub
  };
  static final int currentweek = 32;
  static final Collection<Schedule> scheduleRef =
      Collection<Schedule>(path: 'Shifts');
  static final UserData<Shift> shiftRef =
      UserData<Shift>(collection: 'reports');
}

var currentStoreID = "1182";
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
