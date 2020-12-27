class Shift {
  bool endClock;
  List<Dates> endTime;
  String latex;
  String role;
  String staffID;
  String startClock;
  List<Dates> startTime;
  Shift(
      {this.endClock,
      this.latex,
      this.role,
      this.staffID,
      this.startClock,
      this.endTime,
      this.startTime});
  factory Shift.fromMap(Map data) {
    return Shift(
      endClock: data['EndClock'] ?? "",
      latex: data['Late'] ?? "",
      role: data['Role'] ?? "",
      staffID: data['StaffID'] ?? "",
      startClock: data['StartClock'] ?? "",
      endTime:
          (data['EndTime'] as List ?? []).map((v) => Dates.fromMap(v)).toList(),
    );
  }
}

class Dates {
  String day;
  String time;
  Dates({this.day, this.time});
  factory Dates.fromMap(Map data) {
    return Dates(day: data['day'] ?? '', time: data['time'] ?? '');
  }
}

class Schedule {
  String checkCode;
  bool published;
  String storeID;
  int weekCode;
  String yearCode;
  Schedule(
      {this.checkCode,
      this.published,
      this.storeID,
      this.weekCode,
      this.yearCode});
  factory Schedule.fromMap(Map data) {
    return Schedule(
      checkCode: data['CheckCode'] ?? "",
      published: data['Published'] ?? "",
      storeID: data['storeID'] ?? "",
      weekCode: data['WeekCode'] ?? 0,
      yearCode: data['YearCode'] ?? "",
    );
  }
}

class Store {
  //stub
}
