WindowGrouper
=============
An AutoIt3 script to group related windows so that whenever one of them get focused the remaining windows will be brought to front. The windows can be grouped by their title string(regex).

Example
=======
Suppose we want to group Notepad and Calculator and bring them top most windows when one of them get focused the WindowGrouper can be run like below

  WindowGrouper.exe "Notepad$" "^Calculator$"
  
We can use regular expressions as title string for more advanced grouping.