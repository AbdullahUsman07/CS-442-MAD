# OOP Lab: Campus Library System
Name: Abdullah Usman
Roll No: 04072313020 

## Reflection Answers

### Q1. What can a subclass using extends use for free that a class using implements has to write itself?
A subclass using `extends` automatically inherits concrete method implementations and state (member variables) from its superclass. A class using `implements` treats the target purely as an interface, meaning it inherits only the method signatures and must provide its own implementation for every single member.

### Q2. Book and Dvd both use Renewable. When would you pick a mixin, and when an abstract parent class?
We pick a mixin when we want to share concrete code horizontally across unrelated classes without forcing them into a rigid parent-child hierarchy. On the other hand, an abstract parent class is picked when the other class is sharing a fundamental core identity, and we want to define a common base type or common constructor parameters.

### Q3. Why must you override hashCode whenever you override ==?
Hash-based collections (such as `HashSet` and `HashMap`) rely on `hashCode` to look up the correct bucket before using `==` to verify object equality. If two objects evaluate to equal via `==` but have different hash codes, the collection will store or search for them in different buckets, leading to duplicate entries and broken lookup behavior.

### Q4. An extension method on String and a subclass of String both add behaviour. Why does Dart let you write the first one but not the second?
In Dart, core classes like `String` are declared as `final` (or cannot be extended) to preserve compiler optimizations, internal memory layout, and runtime guarantees. Extension methods bypass this limitation because they do not alter the class hierarchy or create a new runtime type; they are purely syntactic sugar resolved at compile-time as static helper functions.