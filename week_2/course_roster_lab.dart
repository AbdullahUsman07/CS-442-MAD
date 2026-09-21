void main(List<String> args) {
  printWelcome("Course Roster Manager");

  // --------------- part-2
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

  // ------------ part-3 ---------------

  // part-3 (i, ii, iv)
  String? instructorEmail;
  print('Instructor Email: ${instructorEmail ?? 'TBA'}');

  // ---------- trying to crash the code
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


  // ------- Part 5 (Operators in Action) ----------
  // Part-5 (i)
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;
  print('Full Group of 3: ${fullGroups} , Leftover: ${leftover}');

  // Part-5 (ii)
  Object formInput = 'twenty-two';
  if(formInput is String){
    print('This is text');
  }
  if(formInput is ! int){
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
}


/// printWelcome function simply take a string as a parameter and displays that string in the console
void printWelcome(String appName) {
  print("===$appName===");
}

// Small setup function to generate code (used in part-3)
String generateCode(String title) =>
    title.substring(0, 2).toUpperCase() + '101';
