Brightness
==========

Ruby script to adjust brightness display(s) in Ubuntu 12.04

I couldn't find one that works for my system so I wrote this one.
It lets me change the brightness of each of my triple monitors at once.


How to use
==========

1.  Clone the folders into a file path of your choosing. We'll call this as <code>&lt;path&gt;</code>.
2.  Press the <code>SUPER</code> command and type <code>Keyboard</code>.
3.  Go the "Shortcuts" tab.
4.  Under "Custom Shortcuts," press the "+" button.
5.  Fill in the details:
      Name:  <code>Brightness Down</code>, Command: <code>&lt;path&gt;/lib/brightness.rb -d</code>

6.  Press "Apply" and then click the shortcut. It'll say "new accelerator..."
7.  Assign a keyboard shortcut that's available. I personally like <code>ALT+SHIFT+F1</code>.  
8.  Repeat steps 4-8 for increasing brightness:
      Name:  <code>Brightness Up</code>, Command: <code>&lt;path&gt;/lib/brightness.rb -i </code>
9.  Profit. CHA-CHING.
