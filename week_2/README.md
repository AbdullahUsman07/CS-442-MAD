# Course Roster Lab - Dart Fundamentals

**Name:** Abdullah Usman

## Completed Parts

* Part 1: Setup & Welcome
* Part 2: Course & Roster Data
  * **Question:** Which of the nine declarations legally could NOT be `const`?
  * **Answer:** `createdAt` – since its value is known only at runtime. Thus, it is the declaration that legally cannot be `const`.
* Part 3: Null-Safe Instructor Info
  * **Deliberate Crash Result:**
    ```text
    Unhandled exception:
    Null check operator used on a null value
    #0      main (file:///D:/CS-442-MAD/week_2/main.dart:29:24)
    #1      _delayEntrypointInvocation.<anonymous closure> (dart:isolate-patch/isolate_patch.dart:311:33)
    #2      _RawReceivePort._handleMessage (dart:isolate-patch/isolate_patch.dart:192:12)
    ```
* Part 4: Formatting Strings
* Part 5: Operators in Action
* Part 6: Enrollment Logic
* Part 7: Reports & Loops