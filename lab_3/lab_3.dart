// lab3.dart - Campus Cafe Order System
// Name: Abdullah Usman , Roll no: 04072313020
import '../basics/first.dart';

const String rollNo = '04072313020';
// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit
const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];
int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;
// ===========================================================================

// ============================= Step 1: Classes and Objects ======================================
// -------- Task 1.1 --------------
class Dish {
  late String name;
  late int price;
}

// ============================= Step 2 & 3: Constructor and this.Shorthand & Named Constructors
// ------- Task 2.1 -------------
class MenuItem {
  // Question: Why price can't be final in this class?
  // An feild declared with final class is immutable (can't be changed after initialization)
  // In Step 2 task 2.2 constructor is reassigning the value using this.price
  // thus declaring it with final would result in a compilation error
  String name;
  int price;

  MenuItem(this.name, this.price) {
    // Task 2.2
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }

  // Task 3.1: Giveaway item constructor
  // Question: The floor is, say, 80 but free() produced 0. Why did the floor
  //logic not run?
  // Answer: We have explicitly defined the named constructor and created the freebie
  // object using MenuItem.free --- The floor logic is applied in the default constructor
  // thus not applied.
  MenuItem.free(this.name) : price = 0;

  // Task no 3.2:
  MenuItem.toString(String text)
    : name = text.split(':')[0].trim(),
      price = int.parse(text.split(':')[1].trim());
}

// =============================== Step 4: Factory Constructor ===================
// Why do _instance and _internal start with an underscore?
// What could go wrong if they did not?
// In OOP (dart) data attributes and function names declared starting with underscore (_)
// are considered private (can't be accessed outside the class).
//
class OrderLog {
  static OrderLog? _instance;
  final List<String> entries = [];

  OrderLog._internal();

  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  }

  void add(String msg) => entries.add(msg);
}

// =============================== Step 5: Initializer List and Assertions ====================
// Task no 5.1
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  OrderLine(this.item, this.qty)
    : assert(qty > 0, 'qty must be positive'),
      total = item.price * qty,
      tax = (item.price * qty * taxPercent) ~/ 100;
}
// Task no 5.2
  OrderLine mainOrder() {
    return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
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
  Dish item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  Dish item2 = Dish();
  int idx2 = (u + 1) % 10;
  item2.name = menu[idx2];
  item2.price = priceOf(idx2);
  item2.price = item2.price - u;

  print('Step1: ${item1.name} Rs ${item1.price}');
  print('Step1: ${item2.name} Rs ${item2.price}');
}

void step2() {
  print('--- Step 2 ---');

  MenuItem a = MenuItem(menu[u], priceOf(u));
  MenuItem b = MenuItem('Tea Special', priceOf(u));

  print('Step2: ${a.name} Rs ${a.price}');
  print('Step2: ${b.name} Rs ${15 * u}');
}

void step3() {
  print('--- Step 3 ---');
  MenuItem freebie = MenuItem.free('Water');

  int i = (u + 2) % 10;
  MenuItem parsed = MenuItem.toString('${menu[i]}:${priceOf(i)}');

  print('Step3: ${freebie.name} Rs ${freebie.price}');
  print('Step3: ${parsed.name} Rs ${parsed.price}');
  print('Step3: Floor=${priceFloor}, free price = ${freebie.price}');
}

void step4() {
  print('--- Step 4 ---');

  OrderLog log1 = OrderLog();
  OrderLog log2 = OrderLog();

  for (int i = 1; i <= u + 2; i++) {
    String msg = 'order #${100 * t * i}';
    if (i % 2 != 0) {
      log1.add(msg);
    } else {
      log2.add(msg);
    }
  }

  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');
}

void step5() {
  print('--- Step 5 ---');
  OrderLine line = mainOrder();

  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }
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
