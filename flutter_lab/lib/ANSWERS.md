# Lab Answers: Study Tracker

**Student Name:** Abdullah Usman
**Roll Number:** 04072313020

## Part A: Numeric Answers

A1: 7

A2: 8

A3: 3

A4: 12

## Part B: Written Answers

### B1: Stateless vs Stateful Widgets
* **Stateless Widgets (`LabApp`, `HomePage`, `StudentCard`, `GoalBanner`):** These classes do not maintain internal mutable state across their lifecycle. Their visual layout depends entirely on parameters passed via their constructors.
* **Stateful Widgets (`Tally`, `Countdown`, `BuggyCounter`):** These classes manage dynamic internal state variables (`_count`, `_left`, `_clicks`) that change over time and require calling `setState()` to notify Flutter to schedule rebuild passes.

### B2: Why Timer must be cancelled in dispose()
The timer must be cancelled inside `dispose()` to prevent memory leaks and runtime errors. If the widget is unmounted while the background periodic timer remains active, timer callbacks will call `setState()` on a defunct State object, throwing a `setState() called after dispose()` exception.

### B3: Const Widgets and Performance
* **Eligible Widgets:** Constructors with compile-time constant arguments whose parameters do not change at runtime (e.g., `const LabApp()`, `const HomePage()`, `const Tally()`, `const Countdown()`, `const BuggyCounter()`, `const SizedBox(...)`, and `const Text(...)`).
* **Benefits:** Marking widgets as `const` allows Flutter to canonicalize and reuse existing widget instances across render passes, skipping unnecessary object reinstantiations during layout rebuilds.