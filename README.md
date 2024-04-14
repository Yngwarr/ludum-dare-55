# How to import songs?

1. Make a MIDI-track for prompts. Use these notes:
    - C4 for left;
    - D4 for down;
    - E4 for up;
    - Anything else for right.
2. Use the "Export project MIDI..." action in Reaper.
3. Export with these settings:
    - Consolidate time: _Entire project_;
    - Consolidate MIDI items: _Selected tracks only_;
    - Merge to single MIDI track (type 0 MIDI-file);
    - Embed project tempo/time signature changes.
4. Drag the produced MIDI-file to the [tone.js converter][midi-converter].
5. Save the resulting JSON as a file in the `songs/` folder.

[midi-converter]: https://tonejs.github.io/Midi/
