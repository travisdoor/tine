# Welcome to Tine text editor.

Use `Alt+X` to see list of all available commands.
Use `Ctrl+O` to open file.

- Author:  Martin Dorazil
- Version: 1.0

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
  | C#       | YES              | YES  |

# Feature Highlights

- Lightweight single executable distribution.
- Fast keyboard oriented navigation.
- Project structure with search in files.
- Simple UI.
- Simple integration of RemedyBG and RAD Debugger.
- Macro system.
- Relative line nubers.

# Philosophy of Tine

Tine is a simple text/code editor that was initially designed as my main work tool,
so I implemented only the features I personally needed. Over time, however, it turned out that it might
also be useful and helpful for others.

The main goal of this editor is to keep the focus on text editing and to avoid being distracted by buttons,
tabs, menus, and animations. Therefore, there is almost no UI. Text navigation and editor interaction are
strictly designed for keyboard use (since I hate moving my hand while typing and using the mouse). However,
some basic mouse support was added later, mainly for situations such as quickly presenting code to
colleagues and similar use cases.

I mostly use C and C++ at work, so the editor is primarily designed for these languages.

I used Emacs extensively, so my Ctrl key is remapped to Caps Lock. I believe this Control key position is
far more ergonomic, and I recommend doing the same. The default Tine keybindings rely heavily on the
Control key. In addition, the right-hand touch-typing home position is used as the basis for cursor movement
 (though the arrow keys can also be used).

# Authors

- **Martin Dorazil** (travis) [**SUPPORT**](https://www.paypal.com/donate/?hosted_button_id=WKSP23ADBFDP6)
- **bovacu**

# Patform

- Windows
- Linux
- Mac

# First Run

## Windows
The editor is distributed as a single small executable containing all the data needed. I
recommend putting the executable into a separate directory because the default configuration
file `default.proj` and `projects` directory will be automatically generated for you next
to the executable.

## Linux & MacOS
Default configuration file `default.proj` will be created in `~/.tine` directory together with
`projects` folder.

# Configuration
The default configuration of the editor can be found in `default.proj` file. This file is created
automatically on the first run. Use `open-default-config` command to open it.

# Projects
To enable some advanced features as "grep search" you need to create a new project file located
in `projects` directory (use `open-projects-directory` to open the disk location in your file
manager). Each project is represented as a single configuration file with `.proj` extension.
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

### Goto Line
Command: `goto-line`
Shortcut: `Alt+G`

Move the cursor in current editor to the line number.

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

Note that this is not intended to replace your terminal; you can only see the output of the last executed
shell command. However, you can easily search, select, and copy the output.

# LSP

Support of LSP is currently experimental and available only for `C/C++` using `clangd` and `CSharp`
using `Roslyn`.

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
