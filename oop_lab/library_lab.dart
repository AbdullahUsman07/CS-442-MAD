// library_lab.dart  -  Campus Library System
// Name: ____________________   Roll no: ____________



const String rollNo = '04072313020'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t; // publication year of titles[i]
final int feePerDay = 5 + t; // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6; // normal number of days late
final int daysBig = 10 + u; // a long overdue period
final int feeCap = 150 + 10 * t; // no single fee may exceed this
final int renewLimit = 1 + t % 3; // renewals allowed per item
final int renewAttempts = 2 + u; // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4; // items on the shelf in Steps 9-10
// ===========================================================================

// ----- Step 1: Classes and Extends -------
abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem(this.title, this.year);

  String describe() => '$title ($year)';

  int lateFee(int days);
}

abstract class Borrowable{

  bool get isAvailable;

  void borrow();
  void giveBack();
}

class Book extends LibraryItem implements Borrowable{
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  @override
  String describe() => '${super.describe()}, $pages pages';

  @override   
  int lateFee(int days) => days * feePerDay;

  @override   
  bool get isAvailable => !_out;

  @override
  void borrow() => _out = true;

  @override    
  void giveBack() => _out = false;
}

class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  @override    
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

class Dvd extends LibraryItem{
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override  
  String describe() => '${super.describe()}, $minutes min';

  @override   
  int lateFee(int days) => days * feePerDay * 2;
}




Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;
  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

Dvd mainDvd() {
  int i = (u + 2) % 10;
  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');

  Book b = mainBook();
  LibraryItem item = b;

  print("Step 1: ${item.title} (${item.year}), ${b.pages} pages");
  // Why item.pages is a compile time error? Because the pages attribute is defined for the inherited child class
  // Book, not for the parent class LibraryItem

  print("Step 1: stored as Library Item: ${item.title}");
  print("Step 1: runtimeType = ${item.runtimeType}");
}

void step2() {
  print('--- Step 2 ---');

  // Question: What would happend if we forgot to add @override?
  // Dart will treat it as declaring a brand-new describe function (in both Book and Magazine).
  // As a result, calling `.describe()` on a `LibraryItem` reference pointing to the object
  // falls back to the parent class definition, outputting only "$title ($year)"
  // without the pages or issue details.

  print("Step 2: ${mainBook().describe()}");
  print("Step 2: ${mainMagazine().describe()}");
}

void step3() {
  print('--- Step 3 ---');

  // final LibraryItem  lib = LibraryItem('x', 2000);
  // Error: The class 'LibraryItem' is abstract and can't be instantiated.
  // Abstract class cannot be instantiated because it represent a blueprint containing methods (without bodies).
  // Dart enforces this restriction at compile time to prevent invoking the unimplemented logic.

  final Book book = mainBook();
  final Magazine magazine = mainMagazine();
  final Dvd dvd = mainDvd();

  print("Step 3:  Book late fee for $daysLate days = ${book.lateFee(daysLate)}");
  print("Step 3:  Magazine late fee for $daysLate days = ${magazine.lateFee(daysLate)}");
  print("Step 3:  Dvd late fee for $daysLate days = ${dvd.lateFee(daysLate)}");
}

void step4() {
  print('--- Step 4 ---');

  /**
   * 'extends' allows to inherit concrete code and feild declarations from a sueprclass. Dart does not support multiple
   * inheritence. Thus, Book class cannot extend both LibraryItem class and Borrowable class. 
   * ssing `implements` treats `Borrowable` purely as an interface, enabling `Book` to satisfy
   * the contract while providing its own custom state management (_out).
   */

  Book book = mainBook();
  
  print("Step 4: available? ${book.isAvailable}");
  book.borrow();
  print("Step 4: borrow? ${book.isAvailable}");
  book.giveBack();
  print("Step 4: return? ${book.isAvailable}");

  final List<LibraryItem> items = [book, mainMagazine(), mainDvd()];
  for (final item in items){
    print("Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}");
  }
}

void step5() {
  print('--- Step 5 ---');
}

void step6() {
  print('--- Step 6 ---');
}

void step7() {
  print('--- Step 7 ---');
}

void step8() {
  print('--- Step 8 ---');
}

void step9() {
  print('--- Step 9 ---');
}

void step10() {
  print('--- Step 10 ---');
}
