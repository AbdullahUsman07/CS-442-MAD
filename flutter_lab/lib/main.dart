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
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Start: $startCount', key: const Key('into-start')),
                Text('Step: $stepSize', key: const Key('info-step')),
                Text('Max: $maxCount', key: const Key('info-max'))
              ],
              ),
              const SizedBox(height: 12,),
              GoalBanner(count: startCount, max: maxCount),
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
    final percent = count * 100 ~/max;
    return Text('Progress: $count for $max ($percent)', key: const Key('progress'));
  }
}

// ---- Provided for Step 7. It has a bug on purpose. Do not rename anything.
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
            _clicks += bugStep;
          },
          child: Text('+$bugStep'),
        ),
      ],
    );
  }
}
