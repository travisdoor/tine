# First Run

## Windows
The editor is distributed as a single, small executable containing all necessary data. I recommend placing the executable in a dedicated directory, as the default configuration file `default.proj` and the `projects` directory will be automatically generated next to the executable.

## Linux & macOS
The default configuration file `default.proj` will be created in the `~/.config/tine` directory, along with the `projects` folder.

# Configuration
The default configuration of the editor can be found in `default.proj` file. This file is created automatically on the first run. Use `open-default-config` command to open it.

# Projects
To enable advanced features like project-wide search (grep), you need to create a project file located in the `projects` directory (use the `open-projects-directory` command to open this location in your file manager). Each project is represented by a single configuration file with a `.proj` extension. In general, a project file should contain at least an `;include` section specifying the project root directory path and an `;include_file_extensions` section. You might also want to override some
settings from the `default.proj` configuration. For more details, see the documentation inside the `default.proj` file (open it via the `open-default-config` command).

To open projects from the `projects` directory use `Ctrl+Shift+O` or `open-project-command`.

# Buffers
Each open file in the editor is represented by a single unique buffer. There are also special buffer kinds - such as *Messages* (which contains a log of all notifications and errors) or *Shell* (which contains the output of the last executed shell command or build) - that exist without a corresponding file on disk.

# Modes
Various editor features are implemented as "modes".

### Run Command
Command: `run-command`
Shortcut: `Ctrl+X`

This is the most fundamental mode, serving as an entry point to all editor features. All possible interactions with the editor are built as commands. You can execute any command by selecting it from the command list.

Use fuzzy search for quick lookups.

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

Recursively lists all files in the project directories specified in the project configuration's `;include` section. Only editable project files (with extensions listed in the `;include_file_extensions` section) will be present in the list.

Use fuzzy search for quick lookups.

### Goto Line
Command: `goto-line`
Shortcut: `Alt+G`

Moves the cursor in the current editor to the specified line number.

### Search
Command: `search-file`
Shortcut: `Ctrl+S`

Searches within the currently focused file buffer. All matching locations are dynamically highlighted as you type. Use `Ctrl+K` or `Ctrl+L` (or arrow keys) to jump between results, `Enter` to return to the editor at the matched location, or `Escape` to cancel the search.

Search currently does not support regular expressions, and matching is case-sensitive.

Use `Ctrl+Enter` to show search results in a split buffer.

To replace search results, use the `Ctrl+R` shortcut.

### Search In Project
Command: `search-in-project`
Shortcut: `Ctrl+Alt+S`

Searches text recursively in all files included in the project as you type.

Use `Ctrl+Enter` to show search results in a split buffer.

### Repeat
Command: `repeat`
Shortcut: `Ctrl+Number`

Repeat mode can be used to repeat the subsequent command N times. The number of repetitions can be specified right after pressing `Ctrl`; you can press `Ctrl+X` to show a list of all commands that can be repeated, or directly invoke them using their shortcuts.

## Shell
Command: `shell`
Shortcut: `Alt+C`

The `shell` command serves as a simple command-line probe, executing any shell command in the current project directory. The shell executable can be adjusted in the configuration file. The output of the shell execution is shown in a separate buffer, which is also used for `build` command output.

In addition, errors and warnings (in the format used by MSVC CL or Clang) are parsed; you can jump between reported source locations using the `Ctrl+.` and `Ctrl+,` shortcuts (`next-error` and `prev-error` commands).

Note that this is not intended to replace your terminal; you can only see the output of the last executed shell command. However, you can easily search, select, and copy this output.

# LSP

LSP support is currently experimental and only available for `C/C++` using `clangd` and `C#` using `Roslyn`.

# clang-format

To use the `clang-format` tool on edited documents, add the `clang-format` executable's location to your system `PATH`. The formatting configuration is expected to be located in the project root directory.

# RemedyBG

Tine has a simple RemedyBG integration that allows you to open the current file location in the RemedyBG debugger and set breakpoints. The `remedybg` executable must be available in your system `PATH`.

# Macros

Tine provides a simple way to record and repeat command sequences. Use `Alt+R` (`toggle-macro-recording`) to start or stop recording. A recorded command sequence can be replayed by pressing `F11` (`replay-macro`). In combination with repeat mode, this feature provides a powerful way to perform complex, repetitive text
modifications.
