# Welcome to the Tine text editor.

- Author:  Martin Dorazil
- Version: 0.1 (ALPHA)

To show help use `Ctrl+X` (to enter command mode), type "help" and press Enter.

- Download: https://travisdp.itch.io/tine
- Source code: https://github.com/travisdoor/tine
- Compiler: https://github.com/travisdoor/bl


# Philosophy of Tine

Tine is a simple text/code editor initially designed as a main work tool just for me,
so I did only things I needed, but after some time it turned out it might be useful and
helpful for others.

The main goal of this editor is to keep the focus on the text editing and not be distracted
too much by buttons, tabs, menus, and animations. So there is almost no UI. Text navigation
and the editor interactions are strictly designed for keyboard use (since I hate moving my
hand during typing and using the mouse); however, some basic mouse support was added after
some time (mostly for cases like a quick presentation of code to colleagues and similar
things).

I mostly use C/C++ at work so the editor is designed to be used with those languages.

I used Emacs a lot so my Ctrl key is remapped to CapsLock. I think such Control key position
is way better and ergonomic, so consider do the same. Default Tine keybinding is a lot about
pressing Control. Also right hand touch-type home position is used as a base for the cursor
movement (arrows can be used too).

My default working OS is Windows, so the editor was designed according to it. However, porting
to other platforms might be possible since the language API used for the editor supports also
Linux and Mac. I just didn't spend too much time implementing features like hot-load and
process execution there.


# First Run

## Windows
The editor is distributed as a single small executable containing all the data needed. I
recommend putting the executable into a separate directory because the default configuration
file `default.proj` and `projects` directory will be automatically generated for you next
to the executable.

## MacOS
Default configuration file `default.proj` will be created in `~/.tine` directory together with
`projects` folder.

# Configuration
The default configuration of the editor can be found in `default.proj` file. This file is created
automatically on the first run. Use `open-default-config` command to open it.

# Projects
To enable some advanced features as "grep search" you need to create a new project file located
in `projects` directory (use `open-projects-directory` to open the disk location in your file
explorer). Each project is represented as a single configuration file with `.proj` extension.
In general, a project file should contain at least `;include` section with a project root
directory path and `;include_file_extensions` section. You also might need to override some
settings from the `default.proj` configuration. For more details see documentation in the
`default.proj` file (`open-default-config` command).

To open projects from the `projects` directory use `Ctrl+Shift+O` or `open-project-command`.

# Modes
Various editor features are implemented as "modes".

### Run Command
Command: `run-command`
Shortcut: `Ctrl+X`

The most fundamental mode serving as an entry point to all editor features. All possible interactions
with the editor are build as commands. You can execute any command you want by choosing one from the
command list.

Use fuzzy-search for a quick lookup.

### Goto Line
Command: `goto-line`
Shortcut: `Alt+G`

Move the cursor in current editor to the line number.

### Open File
Command: `open-file`
Shortcut: `Ctrl+O`

Open the file from disk.

### Open Project
Command: `open-project`
Shortcut: `Ctrl+Shift+O`

Open project from `projects` directory.

### Quick Open
Command: `quick-open`
Shortcut: `Ctrl+P`

List recursively all files in the project directories specified in project config `;include` section.
Only editable project files (with extensions listed in `;include_file_extension` section) will
be present in the list.

Use fuzzy-search for a quick lookup.

### Search
Command: `search-file`
Shortcut: `Ctrl+S`

Search in the current focused file buffer. All matching locations are dynamically highlighted
as you type. Use `Ctrl+K` or `Ctrl+L` (or arrows) no jump between resuts, `Enter` to jump back
to the editor at the found match location or `Escape` to cancel the search.

The search currently does not support regex and match detection is not case sensitive.

### Search In Project
Command: `search-in-project`
Shortcut: `Ctrl+Alt+S`

Search text recursively in all files included in the projec as you type.


## Build
Command: `build`
Shortcut: `F4`

**Currently Windows only.**

When the `build` command is executed Tine will try to execute `build.bat` file in the project directory,
result is presented in a read-only buffer. In case the output contains errors or warning in a known format
(currently CL and Clang compiler outputs are supported), you can jump between reported source locations
by pressing `Ctrl+.` and `Ctrl+,` shortcuts (`next-error` and `prev-error` commands).