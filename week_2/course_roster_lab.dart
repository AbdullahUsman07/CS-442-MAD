import 'dart:convert';

void main(List<String> args) {
  // ------------- Part 1: Setup & Welcome -----------------
  printWelcome("Course Roster Manager");

  // -------------- Part 2: Course & Roster Data ----------
  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();
  String courseTitle = 'CS442: Mobile Application Developement';
  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;
  List<String> enrolledStudents = ['Saqlain', 'Ahmed', 'Hanan'];
  Set<String> waitList = {'Jamil', 'Usman'};
  Map<String, int> attendanceCount = {'Saqlain': 3, 'Ahmed': 4, 'Hanan': 5};

  // Printing (on-console) using Interpolated String
  print(
    "${courseTitle} | Capacity: ${capacity} | Enrolled: ${enrolledStudents.length}",
  );

  // -------------- Part-3: Null Safe Instructor Info -----------------

  // part-3 (i, ii, iv)
  String? instructorEmail;
  print('Instructor Email: ${instructorEmail ?? 'TBA'}');

  // --- trying to crash the code
  //print(instructorEmail!);

  late String enrollmentCode;

  enrollmentCode = generateCode(courseTitle);
  print("Enrollment Code: ${enrollmentCode}");

  // ------------------Part-4 (Formatting Strings) ----------------------
  String rawNames = ' Saqlain, Hanan ,Ahmed , Jamil ';
  List<String> cleanNames = [];
  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }

  print('CleanNames: $cleanNames');

  String courseDescription =
      '''
Course: $courseTitle
Credits: $creditHours
''';
  print(courseDescription);
  print('Seats left: ${capacity - enrolledStudents.length}');

  // ---------------- Part 5 (Operators in Action) ----------
  // Part-5 (i)
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;
  print('Full Group of 3: ${fullGroups} , Leftover: ${leftover}');

  // Part-5 (ii)
  Object formInput = 'twenty-two';
  if (formInput is String) {
    print('This is text');
  }
  if (formInput is! int) {
    print('Input is confirmed Not to be integer!');
  }

  // Part-5(iii)
  var reportBuffer = StringBuffer()
    ..write('Report: ${courseTitle}')
    ..write(' | Cap: ${capacity}')
    ..write(' | Roster: ${enrolledStudents.length}');
  print(reportBuffer.toString());

  // part-5(iv)
  List<String>? extraNotes;
  extraNotes?..add('Room change pending');
  print('Extra notes: $extraNotes');

  // part-5 (v)
  int? bonusSeats;
  bonusSeats ??= 0;
  print(bonusSeats);

  // ------------- Part 6: Enrollement Logic ------------
  // part 6 (i)
  if (isOpen && enrolledStudents.length < capacity) {
    print('You are Enrolled. Welcome!');
  } else {
    print('Enrollment Closed!');
  }

  // Part 6-ii
  int enrollmentStatusCode = 200;
  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;
    case 404:
      print('Course not found');
      break;
    default:
      print('Unknown Error Occured!');
      break;
  }

  // part-6 (iii)
  String statusTag = isOpen ? 'OPEN' : 'FULL';
  print(statusTag);

  // --------------- Part 7: (Reports & Loops)-------------
  for (var student in enrolledStudents) {
    print(student);
  }

  attendanceCount.forEach((student, count) {
    print('$student: $count');
  });

  List<String> announcements = [
    'Welcome to $courseTitle',
    if (!isOpen) 'Course is FULL — waitlist open',
    for (var student in waitList)
      'Reminder: $student, please confirm attendance',
  ];

  for (var announcement in announcements) {
    print(announcement);
  }
}

/// printWelcome function simply take a string as a parameter and displays that string in the console
void printWelcome(String appName) {
  print("===$appName===");
}

// Small setup function to generate code (used in part-3)
String generateCode(String title) =>
    title.substring(0, 2).toUpperCase() + '101';
