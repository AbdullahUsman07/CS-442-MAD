// main.dart - Team Board lab

import 'dart:async';

import 'package:flutter/material.dart';

const String studentName = 'Abdullah Usman';
const String rollNo = '04072313020';

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
const List<String> names = ['Ali', 'Sara', 'Omar', 'Hina', 'Zain', 'Maya'];
const List<String> mains = [
  'start',
  'center',
  'end',
  'spaceBetween',
  'spaceAround',
  'spaceEvenly',
];
const List<String> crosses = ['start', 'center', 'end'];
const List<String> hues = ['teal', 'indigo', 'orange', 'pink', 'green'];
const Map<String, MaterialColor> swatches = {
  'teal': Colors.teal,
  'indigo': Colors.indigo,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'green': Colors.green,
};

final String course = courses[u];

// Steps 1-2: the clock
final int startSec = 5 * (1 + t % 5); // where the clock starts
final int tick = 1 + u % 3; // how much it adds every second
final int ticks = 4 + u % 4; // how many ticks until it stops
final int stopAt = startSec + ticks * tick; // the clock stops here

// Steps 4-5: the tiles
final String tileA = names[u % 6];
final String tileB = names[(u + 2) % 6];
final String tileC = names[(u + 4) % 6];
final int tapsToMake = 2 + t % 3; // used by the experiment in Step 5

// Step 6: axes (the NAMES are printed on the settings card; you type the enum)
final String mainName = mains[u % 6];
final String crossName = crosses[t % 3];

// Step 8: Expanded and Flexible
final double fixedW = 70.0 + 10 * u;
final int flexA = 1 + t % 3;
final int flexB = 1 + u % 2;

// Step 9: Container
final double boxMargin = 4.0 + 2 * (t % 5);
final double boxPad = 8.0 + 2 * (u % 5);
final double boxRadius = 4.0 * (1 + (t + u) % 4);
final double boxBorder = 1.0 + t % 3;
final String hue = hues[(t + u) % 5]; // use swatches[hue]!.shade100

// Step 10: Stack
final double dotTop = 4.0 + 4 * (t % 4);
final double dotRight = 4.0 + 4 * (u % 4);
final double dotBottom = 4.0 + 4 * ((t + u) % 4);
final double dotLeft = 4.0 + 4 * ((t + 2 * u) % 4);
// ===========================================================================

// Step 2 writes to this list from initState and dispose.
final List<String> lifecycleLog = <String>[];

void main() => runApp(const LabApp());

// Keep the name LabApp and its const constructor: the checker uses them.
class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Team Board', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Board: $course')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsCard(),
            const SizedBox(height: 12),
            Clock(),
            const SizedBox(height: 12),
            const Welcome(),
            const SizedBox(height: 12),
            const SwapBoard(),
            const SizedBox(height: 12,),
            const InfoPanel(),
            const SizedBox(height: 12,),
            const SummaryRow(),
            const SizedBox(height: 12,),
            const ShareRow(),
          ],
        ),
      ),
    );
  }
}

// ---- Provided: shows YOUR numbers. Keep it on the page. Do not rename.
class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'YOUR SETTINGS (seed $seed)\n'
      'clock: start $startSec, tick $tick, stop at $stopAt\n'
      'tiles: $tileA, $tileB, $tileC (taps for the Step 5 experiment: $tapsToMake)\n'
      'row main axis: $mainName | column cross axis: $crossName\n'
      'flex: $flexA and $flexB | fixed width: ${fixedW.toStringAsFixed(0)}\n'
      'box: margin $boxMargin, padding $boxPad, radius $boxRadius, '
      'border $boxBorder, colour $hue\n'
      'stamp: top $dotTop, right $dotRight, bottom $dotBottom, left $dotLeft',
      key: const Key('settings'),
      style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
    );
  }
}

// ====================== Step 7 ==========================
// Wrapping a Text in Expanded causes it to wrap words because Expanded passes down a tight maximum width constraint to its child based on the remaining space in the Row.
// Under Flutter's "constraints go down, sizes go up" layout rule, 
// Row -> Expanded -> Text passes down a max width constraint. The Text widget calculates line breaks to fit within that constrained width and reports its calculated height back up.
class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Part A: read the widget tree of the $course board from top to bottom.',
            key: const Key('sum-a'),
          ),
        ),
        Expanded(
          child: Text(
            'Part B: build each box from small widgets and never extend a built-in class.',
            key: const Key('sum-b'),
          ),
        ),
        Expanded(
          child: Text(
            'Part C: break the layout on purpose, then fix it with Expanded or Wrap.',
            key: const Key('sum-c'),
          ),
        ),
      ],
    );
  }
}

// ============== Step 1 ===================
// Question ....
// Answer: We start the Timer in initState() because it runs exactly once when the State object is inserted into the tree.
// On the contrary, if we start the Timer inside the build(), a new Timer will be created, every time the widget rebuilds (on every setState).
// This would accumulate multiple active timers running simultaneously, causing the clock speed to accelarate rapidly and leak memory.

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  int _seconds = startSec;

  int _builds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _seconds += tick);
      if (_seconds >= stopAt) _timer.cancel();
    });
  }

  // ===================== Step 2 ========================
  // Question
  // 1- Builds increases by 1 per second because setState() is triggered exactly once per second inside the Timer callback, causing
  // a single rebuild per tick
  // 2- If _timer.cancel() were omiited in dispose() and widget left on the screen, the active _timer would attemp to call setState() on
  // an unmounted State object, throwing "setState() called after dispose() " in the console.
  @override
  void dispose() {
    _timer.cancel();
    lifecycleLog.add('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _builds++;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Session: $_seconds s', key: const Key('clock')),
        Text('Builds: $_builds', key: const Key('builds')),
        Probe(seconds: _seconds),
      ],
    );
  }
}

// ====================== Step 3 ===========================
// Question
// - Widget: cheap, immutable, and thrown away on every rebuild
// - Element: Persistent, stays in memory across rebuilds, and manages teh underlying state
// - RenderObject - Managed by the Element in Render Tree; handles actual layout, painting, and hit-testing on screen.
class Probe extends StatelessWidget {
  final int seconds;
  const Probe({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    final bool above =
        context.findAncestorWidgetOfExactType<Scaffold>() != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seen at $seconds', key: const Key('probe-seen')),
        Text(
          'Widget #${identityHashCode(this)}',
          key: const Key('probe-widget'),
        ),
        Text(
          'Element #${identityHashCode(context)}',
          key: const Key('probe-element'),
        ),
        Text(
          'Context belongs to: ${context.widget.runtimeType}',
          key: const Key('probe-context'),
        ),
        Text('Scaffold above me: $above'),
      ],
    );
  }
}

// ========================= Step 4 ==================================
//

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Welcome: $studentName', key: const Key('welcome')),
    );
  }
}

class Tile extends StatefulWidget {
  const Tile(this.label, {super.key});

  final String label;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  int taps = 0;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          taps++;
        });
      },
      child: Text('${widget.label}: $taps'),
    );
  }
}

// ========================== Step 5 ===============================
//

class SwapBoard extends StatefulWidget {
  const SwapBoard({super.key});

  @override
  State<SwapBoard> createState() => _SwapBoardState();
}

class _SwapBoardState extends State<SwapBoard> {
  var tiles = [
    Tile(tileA, key: const Key('tileA')),
    Tile(tileB, key: const Key('tileB')),
    Tile(tileC, key: const Key('tileC')),
  ];

  void swap() => setState(() {
    tiles = tiles.reversed.toList();
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: tiles),
        ElevatedButton(onPressed: swap, child: const Text('swap')),
      ],
    );
  }
}


// ========================== Step 6 ========================
// 1: In a column, the main axis is the VERTICAL axis (top to bottom).
// 2: The cross axis is the HORIZONTAL axis (left to right). whereas mainAxisAlignment controls vertical positioning (moving items up/down).

class InfoPanel extends StatelessWidget {
  const InfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          key: const Key('info-row'),
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Start: $startSec s', key: const Key('row-a'),),
            Text('Tick: $tick s', key: const Key('row-b')),
            Text('Stop: $stopAt s', key: const Key('row-c')),
          ],
          ),
        const SizedBox(height: 12,),
        Column(
          key: const Key('info-col'),
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Name: $studentName', key: const Key('col-a')),
            Text('Roll no: $rollNo', key: const Key('col-b')),
            Text('Course: $course', key: const Key('col-c')),
          ],

        )
      ],
    );
  }
}


// ============================== Step 8 ===================================
// 1. Expanded forces its child to fill all available space allocated to its flex factor (it uses FlexFit.tight).
// Flexible allows its child to take up to its allocated space but lets it remain smaller if its child's natural size is smaller (FlexFit.loose).
// 2. Expanded is literally "Flexible with fit: FlexFit.tight".
// 3. If you swapped Expanded and Flexible between the two buttons, the second button (now Flexible) would shrink down to fit its text 'Exp',
// while the third button (now Expanded) would stretch tight to fill its entire flex space.
class ShareRow extends StatelessWidget {
  const ShareRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('share-row'),
      children: [
        SizedBox(
          key: const Key('fixed'),
          width: fixedW,
          child: ElevatedButton(onPressed: (){}, child: const Text('F')),
        ),
        Expanded(
          flex: flexA,
          child: ElevatedButton(
            key: const Key('exp'),
            onPressed: (){}, child: const Text('Exp'))
        ),
        Expanded(
          flex: flexB,
          child: ElevatedButton(
            key: const Key('flex'),
            onPressed: (){}, child: const Text('Flex')))
      ],
    );
  }
}