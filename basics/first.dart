
/// 1- main function, that demonstrates the prinitng of arguments passed during command line execution.

void main(List<String> args){
  if(args.isEmpty){
    print('No name given!');
  }else{
    print('Hello, ${args[0]}');
  }

  print("----------------");

  /// 2- Loop demonstration
  List<String> members = ['Jamil', 'Ahmed', 'Tariq'];

  for(var m in members){
    print('Hello, ${m}');
  }
}


/// 3- Different String usages
var name, price, quantity;

var a = 'Hello, $name'; // interpolation
var b = 'Total price: ${price * quantity}';
var c = r'C:\folder\bin.exe'; // raw String
var d = '''Mulit-Line String:
            can span on multiple lines''';