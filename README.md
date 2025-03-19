# Welcome to the Tine text editor.
**To see the list of all available commands use `Ctrl+X` shortcut.**

- Author:  Martin Dorazil
- Version: 0.10

## Links

- Download: https://travisdp.itch.io/tine
- Source code: https://github.com/travisdoor/tine
- Compiler: https://github.com/travisdoor/bl
- Discord: https://discord.gg/cmDSGMhwYT

## Tutorials

- Introduction: https://youtu.be/vE9m_v0OPqE
- RemedyBG workflow: https://youtu.be/2JmT6_gce8g
- Repeat mode & macros: https://youtu.be/8FxoyvfCiOc?si=zEccV3FbVi8l6yvx

# Supported Languages

  | Language | Syntax Highlight | LSP  |
  | -------- | ---------------- | ---- |
  | BL       | YES              | NO   |
  | C        | YES              | YES  |
  | C++      | YES              | YES  |
  | Markdown | YES (basic)      | NO   |
  | GLSL     | YES              | NO   |

# Feature Highlights

- Lightweight single executable distribution.
- Fast keyboard oriented navigation.
- Project structure with search in files.
- Simple UI.
- Simple integration of RemedyBG and RAD Debugger.
- Macro system.
- Relative line nubers.

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

# Authors

- **Martin Dorazil** (travis) [**SUPPORT**](https://www.paypal.com/donate/?hosted_button_id=WKSP23ADBFDP6)
- **bovacu**

# Platform

Tine editor is actively developed on Windows and only Windows executable is currently available on
https://travisdp.itch.io/tine. However, it's possible to compile Tine also for Linux and mac from
the source code, but there might be some incomplete stuff and issues. See the [developer](#developer)
section.

# First Run

## Windows
The editor is distributed as a single small executable containing all the data needed. I
recommend putting the executable into a separate directory because the default configuration
file `default.proj` and `projects` directory will be automatically generated for you next
to the executable.

## MacOS
Default configuration file `default.proj` will be created in `~/.tine` directory together with
`projects` folder.

## Linux
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

# Buffers
Each file open in the editor is represented as a single unique buffer. There are some special buffer
kinds like *Messages* (containing log of all notifications and errors) or *Shell* (containing output of
the last executed shell command or build) existing without any actual file on the disk.

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

Use `Ctrl+Enter` to show search results in split buffer.

To replace found results use `Ctrl+R` shortcut.

### Search In Project
Command: `search-in-project`
Shortcut: `Ctrl+Alt+S`

Search text recursively in all files included in the projec as you type.

Use `Ctrl+Enter` to show search results in split buffer.

### Repeat
Command: `repeat`
Shortcut: `Ctrl+Number`

Repeat mode can be used to repeat any following command N times. Number of invocations can be specified
right after pressing Ctrl; you can use Ctrl+X to show list of all command which can be repeated or directly
invoke such command using shortcut.

## Shell
Command: `shell`
Shortcut: `Alt+C`

The `shell` command serves as a simple command line probe executing any shell command in current project
directory. The shell exectutable might be adjusted in the config file. The output of shell execution is
shown in a separate buffer which is used also for the `build` command output.

In addition errors and warnings (in format used by CL or Clang) are parsed; you can jump between reported
source locations by pressing `Ctrl+.` and `Ctrl+,` shortcuts (`next-error` and `prev-error` commands).

# LSP

Experimental integration of LSP is available for C/C++ using `clangd` LSP server. To make it work, you
need `clangd` installed and available in system `PATH`. You need to set `use_lsp` to `true` in project
or global configuration file to enable the integration. The `compile_commands.json` file is supposed to
be placed in the project root directory (can be generated by CMake).

# clang-format

To use clang format tool on eddited documents, include the `clang-format` executable location to your
system `PATH`. The formatting configuration is supposed to be in project root directory.

# RemedyBG

Tine has simple RemedyBG integration where you can open current file location in the RemedyBG debugger and
set breakpoints. The `remedybg` executable must be available in your system `PATH`.

# Macros

Tine provides simple way to record and repeat command sequence, use Alt+R (toggle-macro-recording) to start
or stop recording mode. Recorded command sequence can be replayed by pressing F11 (replay-macro). In
combination with repeat mode, this feature provides powerful way to do more complex repetitive text
modifications.

# Developer

Tine text editor is written in a custom language called *Biscuit* (https://github.com/travisdoor/bl). The
latest *master* compiler version is required.

To compile debug version use:

```
blc -build
```

To compile release version use:

```
blc -build --release
```

## Macos

MacOS version (on Apple Silicon) should be feature complete, however, not tested so much.

To creates self-contained application bundle use `build-macos-app.sh`. This script creates release
version of the editor, and use `dylibbundler` (installed via `brew`) to resolve all dependencies
and packing them into the application bundle. Result can be found in `tine-macos-arm64` directory.
