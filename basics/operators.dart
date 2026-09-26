// Some dart specific operators are listed below.

// ------------------(~/)--------------------
//  there is round down operator (~/) --- which divided and rounds down

// void main(List<String> args) {
//   int a, b, c;

//   a = int.parse(args[0]);
//   b = int.parse(args[1]);

//   c = a ~/ b;
//   print("$a ~/ $b = $c");
// }


// ----------------(??=)-------------------------------

// next operator, (??=) -- assign only if null
// void main(){
//   int? highscore;
//   highscore ??= 0; // will chanage to 0, because it is null
//   highscore ??= 100; // will not change because it is not null
//   print(highscore);
// }


// --------------------(..)-------------------
// cascade operator, lets you call methods on one object withour repeatin it's name
var cart = <String>[]
    ..add('Pepsi')
    ..add('Chips')
    ..add('Ranch');


// --------------------(?..)-------------------
// null safety cascade, it skips the whole chain instead of crashing
List<String>? checkOut;
void main() {
    checkOut?..remove('pen');
}