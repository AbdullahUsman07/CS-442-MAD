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
  String formatTitle(String title, [String? author]){
    return author == null ? title : "Title by Author $author";
  }

  // Task 1.3: Named parameters with a required and default
  Map<String, dynamic> makeBook({required String title, required String author, int year = 2024, int copies = 1}){
    return {
      "title": title,
      "author": author,
      "year": year,
      "copies": copies
    };
  }

  // Task 1.4: Arrow functions
  bool isClassic(int year) => year<2000;

  // ---------------------------------- Part 2 Functions ------------------------------
  // Task 2.1: Passing function as an argument
  List<String> transformAll(List<String> items, String Function(String) fn){
    List<String> results = [];

    for(var item in items){
      results.add(fn(item));
    } 

    return results;
  }

  // Task 2.2: A closure that rememebers
  int Function() makeCounter(){
    int count = 0;

    int counter(){
      count ++;
      return count;
    }
    return counter;
  }

  // Task 2.3: Closure with a parameter 
  double Function(int) makeCalculator(double rate){
    double dailyRate(int days){
      return rate * days;
    }

    return dailyRate;
  }


  //Task 2.4: Recursion
  int sumDigits(int n){
    if(n < 10){
      return n;
    }

    return (n % 10) + sumDigits(n~/10);
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
  print(makeBook(title: "Clean Code", author: "Knuth",year: 1968));
  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');
  List<String> task_2_2 = transformAll(['Dart in Action', 'CLean Code'], (String s){
    return s.toUpperCase();
  });
  print(task_2_2);

  List<String> task_2_2_2 = transformAll(['Dart in Action', 'Clean Code'], (String s) => '$s!');
  print(task_2_2_2);

  var desk1 = makeCounter();
  var desk2 = makeCounter();
  print(desk1()); print(desk1()); print(desk1());
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
}

void part4() {
  print('--- Part 4 ---');
}

void part5() {
  print('--- Part 5 ---');
}

Future<void> part6() async {
  print('--- Part 6 ---');
}
