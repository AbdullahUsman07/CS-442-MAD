
# Layout Lab Answers

**Name:** Abdullah Usman
**Roll no:** 04072313020

## Numeric Answers

A1: 19
A2: 5
A3: 4
A4: 75

## Reflection Answers
### B1: Stateless vs Stateful
- **Stateless Widgets (`Welcome`, `InfoPanel`, `SummaryRow`, `ShareRow`, `InfoBox`, `StampStack`, `SettingsCard`):** These widgets have immutable properties and do not hold internal state that changes over time.
- **Stateful Widgets (`Clock`, `Tile`, `SwapBoard`):** These widgets manage mutable internal state across rebuilds (e.g. active timer/seconds counter in `Clock`, tap counts in `Tile`, and list order in `SwapBoard`).

### B2: Widget, Element, RenderObject
- **Widget:** Immutable declaration of UI configuration; recreated on every rebuild (`setState`).
- **Element:** Persistent tree node that bridges Widget and RenderObject; stays in memory across rebuilds and holds State.
- **RenderObject:** Persistent object handling layout, sizing, and painting on screen.
- **Probe Demonstration:** Every second, `Widget #` hash changed because a new `Probe` widget instance was constructed, whereas `Element #` hash remained unchanged.

### B3: Constraints Go Down, Sizes Go up
In Step 7 (`SummaryRow`), `Row` passes horizontal tight constraints down to `Expanded`, which in turn passes maximum width constraints down to `Text`. The `Text` widget wraps its contents based on that width constraint and passes its calculated height back up to the parent.