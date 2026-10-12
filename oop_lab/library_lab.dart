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

  static int created = 0;

  LibraryItem(this.title, this.year) {
    created++;
  }

  static int capFee(int fee) => fee > feeCap ? feeCap : fee;

  String describe() => '$title ($year)';

  int lateFee(int days);
}

List<LibraryItem> buildShelf() {
  final List<LibraryItem> shelf = [];

  for (int k = 0; k < shelfSize; k++) {
    final int i = (u + k) % 10;
    if (k % 3 == 0) {
      shelf.add(Book(titles[i], yearOf(i), 100 + 3 * seed));
    } else if (k % 3 == 1) {
      shelf.add(Magazine(titles[i], yearOf(i), 1 + (t + k) % 12));
    } else {
      shelf.add(Dvd(titles[i], yearOf(i), 90 + seed % 40));
    }
  }
  return shelf;
}

// Step 5: Mixins
mixin Renewable {
  int renewals = 0;
  bool renew(limits) {
    if (renewals >= limits) return false;

    renewals++;
    return true;
  }
}

abstract class Borrowable {
  bool get isAvailable;

  void borrow();
  void giveBack();
}

// ----------------- Step 6: Enhanced Enums -----------------
enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;
  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) => fee - (fee - discountPercent ~/ 100);
}

// --------------- Step 8: Operators, == and Hashcode
class Fine {
  final int amount;

  const Fine(this.amount);

  Fine operator +(Fine o) => Fine(amount + o.amount);

  bool operator >(Fine o) => amount > o.amount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Fine && other.amount == amount);

  @override
  String toString() => 'Fine ($amount)';

  @override
  int get hashCode => amount.hashCode;
}

class Book extends LibraryItem with Renewable implements Borrowable {
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

class Dvd extends LibraryItem with Renewable {
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

// Step 7
extension MoneyText on int {
  String get rs => 'Rs $this';
}

extension Initials on String {
  String get initials => split(' ').map((w) => w[0]).join();
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) =>
      fold(0, (sum, item) => sum + item.lateFee(days));
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

  print(
    "Step 3:  Book late fee for $daysLate days = ${book.lateFee(daysLate)}",
  );
  print(
    "Step 3:  Magazine late fee for $daysLate days = ${magazine.lateFee(daysLate)}",
  );
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
  for (final item in items) {
    print("Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}");
  }
}

void step5() {
  print('--- Step 5 ---');

  // Why mixin is a better fit?
  // Putting `renew()` inside `LibraryItem` would force subclasses like `Magazine`
  // to inherit renewal functionality that they should not have.
  // A mixin enables horizontal code sharing (reusing code across different branches
  // without a parent-child relationship), letting `Book` and `Dvd` share the exact
  // same implementation without polluting the base class.

  final Book book = mainBook();
  int ok = 0;

  for (int i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }

  print("Step 5: renewed $ok of $renewAttempts  attempts (limit $renewLimit)");
  print("Step 5: renew once more? ${book.renew(renewLimit)}");
  print("Step 5: dvd can renew too? ${mainDvd().renew(1)}");
}

void step6() {
  print('--- Step 6 ---');

  // Why is MemberType.student safer than the string 'student'?
  /**
  * A raw string like 'student' is prone to
  * typos (e.g., 'studnet') that fail silently until runtime, whereas an enum guarantees
  * exhaustive and strictly validated options.
  */

  final MemberType type = MemberType.values[seed % 3];
  final int fee = mainBook().lateFee(daysLate);

  print("Step 6: member type = ${type.name} (index ${type.index})");
  print("Step 6: max loans = ${type.maxLoans}");
  print("Step 6: book fee $fee -> ${type.applyDiscount(fee)} after discount");
}

void step7() {
  print('--- Step 7 ---');

  final MemberType type = MemberType.values[seed % 3];
  final int bookFee = mainBook().lateFee(daysLate);
  final int discountedFee = type.applyDiscount(bookFee);

  final List<LibraryItem> shelf = [mainBook(), mainMagazine(), mainDvd()];

  print("Step 7: ${discountedFee}.rs");
  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');
  print(
    "Step 7: shelf fee for $daysLate days = ${shelf.totalLateFee(daysLate)}.rs",
  );
}

void step8() {
  print('--- Step 8 ---');

  // If `hashCode` is omitted, Dart uses identity-based hashing from `Object`.
  // Hash collections (like Set and Map) inspect `hashCode` first to locate the bucket
  // before checking equality via `==`. Without overriding `hashCode`, two different
  // instances with the same amount generate different hash codes, placing them in
  // separate buckets and increasing the set size from 2 to 3.
  // Dart contract requires that if two objects evaluate to equal via `==`,
  // they must produce the identical `hashCode`.
  final Fine f1 = Fine(mainBook().lateFee(daysLate));
  final Fine f2 = Fine(mainMagazine().lateFee(daysLate));

  print('Step 8: $f1 + $f2 = ${f1 + f2}');
  print('Step 8: first bigger? ${f1 > f2}');
  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');
  print('Step 8: set size = ${{f1, Fine(f1.amount), f2}.length}');
}

void step9() {
  print('--- Step 9 ---');

  //  Why can created be read as LibraryItem.created without making any object first?
  /**
   * Since created is declared with the static keyword. Dart allocates static members with the class
   * type itself, so they exist and can be exist without instantiating any object first.
   */

  LibraryItem.created = 0;
  buildShelf();
  final List<LibraryItem> shelf = buildShelf();

  print('Step 9: items created ${LibraryItem.created}');
  print('Step 9: capped fee ${LibraryItem.capFee(shelf.first.lateFee(daysBig))} (cap$feeCap)');
  print('Step 9: const copies identical? ${identical(const Fine(10), const Fine(10))}');
  print('Step 9: new copies identical? ${identical(Fine(10), Fine(10))}');
}

void step10() {
  print('--- Step 10 ---');
}
