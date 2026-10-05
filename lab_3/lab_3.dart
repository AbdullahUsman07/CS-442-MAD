// lab3.dart - Campus Cafe Order System
// Name: Abdullah Usman , Roll no: 04072313020

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
  MenuItem.fromString(String text)
    : name = text.split(':')[0].trim(),
      price = int.parse(text.split(':')[1].trim());

  @override
  String toString() => '$name (Rs $price)';
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

  // =========================== Step 6: Getters ===================================
  int get grand => total + tax;
  bool get isBigOrder => grand > bigOrderLimit;
  String get label => '${item.name} x${qty}';
}

// Task no 5.2
OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

// ================================ Step 7: Setters ==============================
// Question: The setter silently clamps a bad value. What is one other thing a setter could do with an invalid value?
// Answer: Instead of clamping (restricting a value within bounds), a setter could
// throw an ArgumentError to explicitly alert the caller to invalid assignment data
class StudentCard {
  final String owner;
  int _balance;

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  // Task 7.1
  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
}

List<MenuItem> buildMenu() {
  return [
    for (int k = 0; k < 4; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}

// =============================== Step 9 Building a recipt ===========================
// Task no 9.1

List<OrderLine> buildReceipt() {
  List<MenuItem> items = buildMenu().sublist(0, 3);
  return [for (int k = 0; k < 3; k++) OrderLine(items[k], 1 + (t + k) % 4)];
}

// ============================= Step 10: Capstone, discount Coupons ============================
class Coupon {
  static final Map<String, Coupon> _cache = {};
  final String code;
  final int percent;
  final int minSpend;

  Coupon(this.code, this.percent)
    : minSpend = percent * 70,
      assert(percent >= 1 && percent <= 50, 'percent must be between 1 and 50');

  // Factory constructor retrieving from or populating the cache
  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(code, () => Coupon(code, couponPercent));
  }

  // Method to compute discount
  int discountOn(int amount) {
    if (amount >= minSpend) {
      return amount * percent ~/ 100;
    }
    return 0;
  }
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
  MenuItem parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');

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
  OrderLine line = mainOrder();
  // line.grand = 5;

  // Error: The setter 'grand' isn't defined for the type 'OrderLine'.
  //'OrderLine' is from 'lab_3.dart'.
  //Try correcting the name to the name of an existing setter, or defining a setter or field named 'grand'.
  // No setter is defined, thus giving the error
  print('Step 6: grand=${line.grand}');
  print('Step 6: big order? ${line.isBigOrder} (limit $bigOrderLimit)');
  print('Step 6: label=${line.label}');
}

void step7() {
  print('--- Step 7 ---');
  StudentCard card = StudentCard('S$seed');

  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');

  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');

  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');

  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order -> ${card.balance}');
}

void step8() {
  print('--- Step 8 ---');

  List<MenuItem> items = buildMenu();

  MenuItem priciest = items.reduce(
    (curr, next) => curr.price > next.price ? curr : next,
  );

  int sum = items.fold(0, (acc, item) => acc + item.price);

  print('Step 8: menu = $items');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}

void step9() {
  print('--- Step 9 ---');

  List<OrderLine> receipt = buildReceipt();
  int receiptTotal = 0;

  for (OrderLine line in receipt) {
    print('Step 9: ${line.label} = ${line.grand}');
    OrderLog().add('receipt: ${line.label}');
    receiptTotal += line.grand;
  }

  print('Step 9: receipt total = $receiptTotal');
  print('Step 9: log size = ${OrderLog().entries.length}');
}

void step10() {
  print('--- Step 10 ---');
  String code = 'CAFE${seed.toString().padLeft(2, '0')}';
  Coupon c1 = Coupon.fromCode(code);
  Coupon c2 = Coupon.fromCode(code);

  List<OrderLine> receiptLines = buildReceipt();
  int receipt = receiptLines.fold(0, (acc, line) => acc + line.grand);
  int discount = c1.discountOn(receipt);

  print(
    'Step 10: ${c1.code} gives ${c1.percent}% off, min spend ${c1.minSpend}',
  );
  print('Step 10: cached? ${identical(c1, c2)}');
  print(
    'Step 10: receipt $receipt, discount $discount, payable ${receipt - discount}',
  );
}



// ========================= Questions ============================
/**
 * Q1. Animal(this.name, this.type); and the verbose constructor give the same result. What
  does the shorthand save you?

  Answer: This shorthand removes boilerplate. It binds the constructor parameters to constructor feilds. Without needing to write
  redundant code like (this.name = name) in the constructor body.

  Q2. When would you choose a named constructor, and when a factory constructor?

  Answer: Named constructors provide multiple ways to instantiate the object. While Factory constructors, when you need to return a cached
  instance instead of returning a freshly created instance.

  Q3. What is the difference between assigning a field in a constructor body and assigning it in an
initializer list?

  Answer: Initializer list executes before the constructor body and before the object is fully formed, (this is required to initialize 
  non-nullable final feilds). On the other hand, assignment using a constructor body happens after the object creation and only work for
  mutable feilds. 

  Q4. Give one reason to use a getter instead of storing the value in a field, and one reason to use a
setter instead of a public field.

Answer: A getter is ideal for dynamic computed properties that should update automatically 
 whenever underlying state changes without storing redundant data. A setter allows input 
 validation and bounds clamping before values are written to private memory.
   
 */