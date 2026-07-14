# Tine Code Editor

*Version: 1.0.0*

- Press **F1** for a quick common shortuct reference.
- Run the `help` command for this help.

## Installation

Optionally, run the `install` command to add the executable to the "Start" menu (available on Windows and Linux).

## Settings

Default editor settings are stored in the `default.proj` configuration file. Use the `settings` command to open the current one, or `open-config-template` to see the original defaults.

## Projects

Editor workflows are based on *project* files in the `projects` directory. Use `open-projects-directory` to open it. Project files follow the same format as `default.proj` and can override any default settings.

Use `open-project` to list and open existing projects.

## Tips

- The editor makes heavy use of the *Control* button; consider remapping it to *Caps Lock*.
- Arrow keys work for movement by default, but there is also a *Ctrl+JKL;* mapping at the touch-typing home position.
- Text selection is somewhat modal and does not use the common *Shift* key. Selection mode is activated with *Ctrl+Space* and deactivated with *Escape*. The first press activates selection mode, the second selects the whole word under the cursor, the third the whole line, the fourth the full line with leading whitespace, and the fifth the current code block or paragraph.
- The `build` command (configured via `build-command`) may produce errors or warnings. Jump to the next or previous error using `next-error` and `prev-error`. Clang/CL-style error messages are supported.
- The `shell` command output is a regular read-only buffer that can be saved, searched, or copied. File locations are parsed using `file_link_regex` and `file_location_regex` from settings. You can jump directly to linked files (useful with *grep* or *git*).
- Files (sometimes called buffers) can be split into two side-by-side editors. Closing the editors does not close the file; it remains open and is highlighted in the `quick-open` list. See `close-buffer` and `close-all-buffers` commands.
- Use `peek-error` to see full content of inline errors or warnings reported by LSP and `copy-inline-error` to copy them to the clipboard.
- Use `copy-file-path` to copy current file path to the clipboard.
