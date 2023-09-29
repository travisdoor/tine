# Welcome to the Tine text editor.

Author:  Martin Dorazil
Version: 0.1

To show this help again press Ctrl+X (to enter command mode), type "help" and press Enter.
To close this help press Alt+Q.

Consider supporting this project at: @Incomplete.


# Philosophy of Tine

Tine is a simple text/code editor initially designed as a main work tool just for me,
so I did only things I needed, but after some time it turned out it might be useful and
helpful for others.

The main goal of this editor is to keep the focus on the text editing and not be distracted
too much by buttons, tabs, menus, and animations. So there is almost no UI. Text navigation
and the editor interactions are strictly designed for keyboard use only (since I hate moving
my hand during typing and using the mouse); however, some basic mouse support was added after
some time (mostly for cases like a quick presentation of code to colleagues and similar
things).

I mostly use C/C++ at work so the editor is designed to be used with those languages; however,
I prefer my own programming language I'm working on in my spare time (BL); the same language
the editor is written in; so there is some support for it also.

I used Emacs a lot so my Ctrl key is remapped to CapsLock. I think such Control key position
is way better and ergonomic, so consider do the same. Default Tine keybinding is a lot about
pressing Control. Also right hand touch-type home position is used as a base for the cursor
movement.

My default working OS is Windows, so the editor was designed according to it. However, porting
to other platforms might be possible since the language API used for the editor supports also
Linux and Mac. I just didn't spend too much time implementing features like hot-load and
process execution there.


# First Run

The editor is distributed as a single small executable containing all the data needed. I
recommend putting the executable into a separate directory because the default configuration
file `default.proj` and `projects` directory will be automatically generated for you next
to the executable.


# Configuration


# Projects


# Modes

## Goto Line
## Open File
## Open Project
## Quick Open
## Buffer Open
## Save File
## Run Command
## Search
## Search In Project

# LSP