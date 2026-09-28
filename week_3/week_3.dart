import 'dart:developer';

final List<Map<String, dynamic>> books = [
  {
    'title': 'Dart in Action',
    'author': 'Ada',
    'year': 2021,
    'copies': 3,
    'tags': ['dart', 'programming'],
  },
  {
    'title': 'Flutter Basics',
    'author': 'Sam',
    'year': 2023,
    'copies': 0,
    'tags': ['flutter', 'mobile'],
  },
  {
    'title': 'Clean Code',
    'author': 'Martin',
    'year': 2008,
    'copies': 2,
    'tags': ['programming', 'design'],
  },
  {
    'title': 'Algorithms',
    'author': 'Knuth',
    'year': 1968,
    'copies': 1,
    'tags': ['programming', 'math'],
  },
  {
    'title': 'UI Design',
    'author': 'Nora',
    'year': 2019,
    'copies': 4,
    'tags': ['design', 'mobile'],
  },
];

// Task 1.1 Positional Parameters
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

// Task 1.2: Optional Positional Parameters
String formatTitle(String title, [String? author]) {
  return author == null ? title : "Title by Author $author";
}

// Task 1.3: Named parameters with a required and default
Map<String, dynamic> makeBook({
  required String title,
  required String author,
  int year = 2024,
  int copies = 1,
}) {
  return {"title": title, "author": author, "year": year, "copies": copies};
}

// Task 1.4: Arrow functions
bool isClassic(int year) => year < 2000;

// ---------------------------------- Part 2 Functions ------------------------------
// Task 2.1: Passing function as an argument
List<String> transformAll(List<String> items, String Function(String) fn) {
  List<String> results = [];

  for (var item in items) {
    results.add(fn(item));
  }

  return results;
}

// Task 2.2: A closure that rememebers
int Function() makeCounter() {
  int count = 0;

  int counter() {
    count++;
    return count;
  }

  return counter;
}

// Task 2.3: Closure with a parameter
double Function(int) makeCalculator(double rate) {
  double dailyRate(int days) {
    return rate * days;
  }

  return dailyRate;
}

//Task 2.4: Recursion
int sumDigits(int n) {
  if (n < 10) {
    return n;
  }

  return (n % 10) + sumDigits(n ~/ 10);
}

//------------------------- Part no 3 ----------------------------
// Task no 3.4
Map<String, int> buildStock() {
  return {for (var b in books) b['title'] as String: b['copies'] as int};
}

// -------------------------- Part no 4 ---------------------
// Task no 4.1
class Box<T> {
  T value;
  Box(this.value);
}

// Task no 4.2
T firstOr<T>(List<T> items, T fallback){
  return items.isEmpty ? fallback: items.first;
}

// Task no 4.3
class Pair<A,B>{
  final A first;
  final B second;

  Pair(this.first, this.second);

  @override
  String toString() {
    
    return '($first , $second)';
  }
}

// ------------------------ Part no 5 ------------------------
// task no 5.1: Custom Exceptions
class BookNotFoundException implements Exception{
  final String title;
  BookNotFoundException(this.title);
}

class BookNotAvailableException implements Exception{
  final String title;
  BookNotAvailableException(this.title);
}

// Task no 5.2: Throwing 
void checkOut(Map<String, int> stock, String title){
  if(!stock.containsKey(title)){
    throw BookNotFoundException(title);
  }
  if(stock[title]! <= 0){
    throw BookNotAvailableException(title);
  }
  stock[title] = stock[title]! - 1;
}

// Task no 5.4: A build in Exception
Map<String, dynamic> findBook(String title){
  return books.firstWhere((b) => b['title'] == title);
}


// ----------------------------- Part no 6 -----------------------------
// task no 6.1
Future<String> fetchBookofTheDay()async{
  await Future.delayed(Duration(seconds: 1));
  return 'Dart in Action';
}

// task no 6.3
Future<String> fetchBroken()async{
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('Server Down!');
}

void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

void part1() {
  print('--- Part 1 ---');
  print(lateFee(5, 0.5));
  print(formatTitle("Dart in Action"));
  print(formatTitle("Dart in Action", "Ada"));
  print(makeBook(title: "Clean Code", author: "Knuth", year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');
  List<String> task_2_2 = transformAll(['Dart in Action', 'CLean Code'], (
    String s,
  ) {
    return s.toUpperCase();
  });
  print(task_2_2);

  List<String> task_2_2_2 = transformAll([
    'Dart in Action',
    'Clean Code',
  ], (String s) => '$s!');
  print(task_2_2_2);

  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  var studentFee = makeCalculator(0.25);
  var staffFee = makeCalculator(0.10);
  print("Student Fee: ${studentFee(4)}");
  print("Staff Fee: ${staffFee(4)}");

  int result = sumDigits(44);
  print("Sum of Digits: $result");
}

void part3() {
  print('--- Part 3 ---');

  // Task 3.1: map and where
  var titles = books.map((b) => b['title'] as String).toList();
  var available = books
      .where((b) => (b['copies'] as int) > 0)
      .map((b) => b['title'] as String)
      .toList();
  print("Titles: $titles");
  print("available: $available");

  // Task 3.2: reduce and fold
  // fold is  used to reduce a collection to a single value
  var totalCopies = books.fold<int>(0, (sum, b) => sum + (b['copies'] as int));
  print("Total Copies: $totalCopies");

  // Task 3.3: Sorting withour damaging the original
  var sortedBooks = List.of(books);
  sortedBooks.sort((a, b) => (a['year'] as int).compareTo(b['year'] as int));
  var sortedTitle = sortedBooks.map((b) => b['title'] as String).toList();
  print("By year: $sortedTitle");

  // Task no 3.4: Map
  var stock = buildStock();
  print('Stock: $stock');
  stock.forEach((title, copies) {
    if (copies == 0) {
      print("Out of Stock: $title");
    }
  });
  print("Copies of Unknown: ${stock['Unknown'] ?? 0}");

  // Task no 3.5: Set
  var allTags = <String>{for (var b in books) ...(b['tags'] as List<String>)};
  print('All Tags: $allTags');

  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};
  print("Union: ${a.union(b)}");
  print("Intersection: ${a.intersection(b)}");
  print("Only in A: ${a.difference(b)}");
}

void part4() {
  print('--- Part 4 ---');

  // Task 4.1: A generic class
  var intBox = Box<int>(5);
  var strBox = Box<String>("dart");
  print("Box<int>: ${intBox.value}");
  print("Box<String>: ${strBox.value}");

  //   intBox.value = "hello";  Compile error: A value of type 'String' can't be assigned to a variable of type 'int'.
  // Try changing the type of the variable, or casting the right-hand type to 'int'

  // Task no 4.2
  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'z'));

  // Task no 4.3
  print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');

  // task no 5.3: try/on/catch/finally
  var stock = buildStock();
  var checkOutList = ['Dart in Action', 'Flutter Basics', 'Unknown Book'];

  for(var title in checkOutList){
    try{
      checkOut(stock, title);
      print("Checked out: $title");
    } on BookNotAvailableException catch(e){
      print("Sorry! ${e.title} has no copies left");
    }on BookNotFoundException catch(e){
      print("Not found: ${e.title}");
    }finally{
      print("Transaction Logged!");
    }
  }

  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  // Task no 5.4: a built in exception
  try{
    findBook('Missing');
  } on StateError{
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');

  // Task no 6.1: Await a Future
  print('Fetching...');
  var book = await fetchBookofTheDay();
  print('Book of the Day: $book');

  // Task no 6.2 what happens without await
  // print('Fetching...');
  // var book_ = fetchBookofTheDay();
  // print('Book of the Day: $book_');
  // console: Instance of 'Future<String>'

  // Task no 6.3: 
  try{
    await fetchBroken();
  }catch(e){
    print('Fetch Failed: $e');
  }
}
