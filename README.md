# rbcurse-extras

Contains additional widgets for the rbcurse ncurses toolkit. rbcurse helps to easily build
ncurses application for text terminals.

rbcurse-extras contains either more complex widgets or less common ones that may be helpful in some applications.

Some less frequently used widgets:

* rlink       - Show a link on a screen.

* rmenulink   - a menu-link like alpines main menu links

* horizlist - a horizontal scrollable list like what I've seen on vim sometimes but I can't get
              it back now. I've only tried it out once. It's cool.

* menutree  - menu inspired by the `most` program. Core replaces this, i think.

The following allow you to put multiple objects in one container and cycle them.

* rmulticontainer

* rmultitextview

Others:

* rmultisplit - column browse pattern, like OSX's directory. As many lists in one widget, can see
                as many as you want, and tab through them. Scrolls lists as you tab.

* rpopupmenu - Similar to menu, but pops up on form, like Ctrl-click on browser

* rvimsplit  - replacement of splitpane, allows placement of widgets in one container, inspired
               by vim's splits

The following have been in rbcurse since version 1 or so, but removed to extras to keep core
as simple and robust as possible. core contains simpler versions of the same. Avoid using them if 
you can use their core counterparts.

* multilinelabel - the original Label. Removed from core, to keep core simple.

* rcomboedit  - the original editable combo from core. Again, moved here to keep core simple.

* rlistbox    - the original editable list. 

* rtable    - the original editable table.  Pretty complex piece of code based on Java's Jtable,
              I don't want this in core, use only if really required.


==  Miscellaneous

rbcurse-extras will not be as stable as core. It will change more frequently. Stuff from experimental
may move here. 

## Install

   `gem install rbcurse-extras`        # the core, and extra stuff

   To install everything:

   `gem install rbcurse`             # the core, extra and experimental stuff

## License

  Same as ruby license.

  (c) copyright rkumar, 2008-2011.
