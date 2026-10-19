// main.dart - Study Tracker lab
import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Abdullah Usman';
const String rollNo = '04072313020'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> courses = [
  'Mobile Dev',
  'Data Structures',
  'Operating Systems',
  'Databases',
  'Networks',
  'Software Eng',
  'AI',
  'Web Engineering',
  'Graphics',
  'Security',
];

final String course = courses[u]; // your course name
final int startCount = 3 + u; // where the tally starts
final int stepSize = 1 + t % 4; // how much + and - change the tally
final int maxCount = 20 + 2 * t; // the tally may never go above this
final int startSeconds = 5 + (t + u) % 6; // where the countdown starts
final int bugStep = 1 + u % 4; // used by BuggyCounter in Step 7
// ===========================================================================

// Step 9 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Step 1 replaces everything below.
    return MaterialApp(title: 'Study Tracker', home: const HomePage());
  }
}

// ------ Step 1 --------
// Question? What is the difference between what runApp receives and what MaterialApp receives as home?
// Answer: runApp recieves the root widget of the application tree and attaches it directly to the flutter engine screen
// while, MaterialApp's home recieves a widget that serves as the default visual screen inside the Material Design UI hierarchy.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Study Tracker: $course')),

      // ---------- Step-3: -----------------
      // Question: How many levels deep is the Text('Max: ..') from LabApp
      // (1)LapApp -> (2)MaterialApp -> (3)HomePage -> (4)Scaffold -> (5)SingleChildScrollView -> (6)Column -> (7)Row -> (8) Text('max')
      // thus, 8 levels deep from LapApp
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentCard(name: studentName, roll: rollNo, course: course),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: $startCount', key: const Key('into-start')),
                Text('Step: $stepSize', key: const Key('info-step')),
                Text('Max: $maxCount', key: const Key('info-max')),
              ],
            ),
            const SizedBox(height: 12),
            const Tally(),
            const SizedBox(height: 12),
            const Countdown(),
            const SizedBox(height: 12),
            const BuggyCounter(),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------- Step 2 ---------------------------------------------
// Question Why are the fields of a StatelessWidget final? What would the compiler say if you removed final?
// Answer: All statelesswidgets are immutable. Flutter creates and destroys widget configurations during layout passes
// rather than mutating them in place. If the final keyword is removed, the analyzer generates a warning that classes
// marked @immutable cannot contain non-final fields.
class StudentCard extends StatelessWidget {
  final String name;
  final String roll;
  final String course;
  const StudentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', key: const Key('student-name')),
            Text('Roll no: $roll', key: const Key('student-roll')),
            Text('Course: $course', key: const Key('student-course')),
          ],
        ),
      ),
    );
  }
}

// -------------------------- Step 4 ----------------------
// Question:  Why does GoalBanner not need setState? What would you have to do to make it show a new count?
// Answer: Because the setState is the method for the StatefulWidget Class. To display  a new count, its parent
// widget must trigger a rebuild pass and must supply new count values when instantiating GoalBanner.
class GoalBanner extends StatelessWidget {
  final int count;
  final int max;

  const GoalBanner({super.key, required this.count, required this.max});

  @override
  Widget build(BuildContext context) {
    final percent = count * 100 ~/ max;
    return Text(
      'Progress: $count for $max ($percent)',
      key: const Key('progress'),
    );
  }
}

// ------------------------- Step 5 --------------------------
// The class Tally has no fields that change, yet _TallyState does. Why are there two classes?
// Answer: Widget objects are immutable and short-lived configuration nodes that flutter creates and disposes in rendering passes.
// The State object persists across element tree rebuild to hold mutable variables like _count and maintain componenet state over time.

class Tally extends StatefulWidget {
  const Tally({super.key});

  @override
  State<Tally> createState() => _TallyState();
}

class _TallyState extends State<Tally> {
  int _count = startCount;

  void _plus() {
    setState(() {
      _count += stepSize;
      if (_count > maxCount) {
        _count = maxCount;
      }
    });
  }

  // ------------------------------------------ Step 6 -----------------------------------
  //  Question: Hot reload while the count is 12. Does it stay 12? Now do a hot restart. Explain the difference using the words widget and State.
  // Answer: On Hot reload the _count stays 12 because hot reload inject updated widget code into the VM while preserving exisitng persistent
  // State objects in the memory. On hot restart, _count resets to zero because it destroys all the existing objects in the memory and re-runs the main()
  void _minus() {
    setState(() {
      _count -= stepSize;
      if (_count < 0) {
        _count = 0;
      }
    });
  }

  void _reset() {
    setState(() {
      _count = startCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Count: $_count', key: const Key('count')),
        GoalBanner(count: _count, max: maxCount),
        Row(
          children: [
            ElevatedButton(
              key: const Key('plus'),
              onPressed: _plus,
              child: Text('+$stepSize'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              key: const Key('minus'),
              onPressed: _minus,
              child: Text('-$stepSize'),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              key: const Key('reset'),
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// ---- Provided for Step 7. It has a bug on purpose. Do not rename anything.
// Question: Before the fix, you tapped three times. What was the value of _clicks inside the State, and what did the screen show? Write both numbers
// Answer: Inside the State memory object, value of the _clicks is 3 (bugStep = 3). On the screen, it showed 0 because without the setState,
// Flutter was never notified to schedule a rebuild pass.
class BuggyCounter extends StatefulWidget {
  const BuggyCounter({super.key});

  @override
  State<BuggyCounter> createState() => _BuggyCounterState();
}

class _BuggyCounterState extends State<BuggyCounter> {
  int _clicks = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Bug clicks: $_clicks', key: const Key('bug-text')),
        const SizedBox(width: 12),
        ElevatedButton(
          key: const Key('bug-button'),
          onPressed: () {
            setState(() {
              _clicks += bugStep;
            });
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}

// --------------------------------- Step 8 ----------------------------
//  Question: What error appears in the console if you delete the _timer.cancel() from dispose and the widget is removed?
// Answer: Flutter throws an exception: setState() called after dispose(): _CountdownState#.... This occurs because the background
// timer continues attempting to call setState() on an unmounted (detached from the element tree) state object.
class Countdown extends StatefulWidget {
  const Countdown({super.key});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late int _left;
  late Timer _timer;
  int _builds = 0;

  @override
  void initState() {
    super.initState();
    lifecycleLog.add('initState');
    _left = startSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _left--);
      if (_left <= 0) timer.cancel();
    });
  }

  @override
  void dispose() {
    lifecycleLog.add('dispose');
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ---------------- Step 9 ----------------
    // Question: Why does it increase by one per second and not by two? Where could you print lifecycleLog to prove that dispose ran?
    // Answer: It increases by one per second because Timer.periodic triggers setState() once every second, causing Flutter to invoke
    // the build() method exactly once per interval. You can print lifecycleLog directly inside the dispose() method after adding
    // the entry, or print it from a parent widget during route destruction.
    _builds++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_left > 0)
          Text('Time left: $_left s', key: const Key('time-left'))
        else
          const Text('Time is up!', key: const Key('time-left')),
        Text('Builds: $_builds', key: const Key('builds')),
      ],
    );
  }
}
