---
title: "Visual Studio Code Setup For Elixir Development"
description: "Visual Studio code is a solid editor out of the box and with a few tweaks it can provide an excellent development experience for the Elixir language."
date: "2018-08-20"
tags: ["visual studio code", "elixir", "tools"]
categories: ["programming"]
draft: false
type: "post"
---

Visual Studio Code Setup For Elixir Development
===============================================

I started using [Visual Studio Code ](https://code.visualstudio.com/) about a year ago while experimenting with TypeScript.  It provides a great development experience for many of my go to languages and it has slowly replaced Emacs as my preferred editor. The following post breaks down the various extensions and tweaks which I use for Elixir development.


## Extensions

VS Code doesn't support Elixir by default but this is easily solved via a few extensions.

### Elixir-specific
- [ElixirLS](https://github.com/JakeBecker/vscode-elixir-ls) - Elixir language support
- [vscode-elixir](https://github.com/fr1zle/vscode-elixir) - Elixir language support
- [hex.pm IntelliSense](https://github.com/benlime/vscode-hex-pm-intellisense) - Recommends package version numbers available on [hex.pm](https://hex.pm)

### Other
- [Vim](https://github.com/VSCodeVim/Vim) - Vim bindings
- [Project Manager](https://github.com/alefragnani/vscode-project-manager) - Quickly switch between project
- [Rainbow Brackets](https://github.com/gastrodia/rainbow-brackets) - Holdover from my Clojure days

## Customizations

### Settings

Just a couple of quick tweaks to get Emmet support working in .eex files and set my preferred autocomplete behavior.

```json
{
    "[elixir]": {
        "editor.wordBasedSuggestions": false,
        "editor.acceptSuggestionOnEnter": "on"
    },
    "emmet.includeLanguages": {"HTML (Eex)": "html"}
}

```

### Keybindings and Tasks

This is where things get interesting.  I'm not a TDD-zealot I do run tests quite often during development so I have a large number of keyboard shortcuts focused on executing various test combinations.

I also have a task to start the Phoenix development server in IEx.  I decided not to add additional mix tasks due to how easy it is to just run them in the built-in terminal.

| Keyboard Shortcut  | Task Name            | Description                                   |
| ------------------ | -------------------- | --------------------------------------------- |
|                    | phx.server           | Start phx.server mix task via IEx in terminal |
| **ctrl-t t**       | Run All Tests        | `mix test`                                    |
| **ctrl-t f**       | Test Current File    | `mix test FILE_NAME`                          |
| **ctrl-t c**       | Run Current Test     | Only run the test under the cursor            |
| **ctrl-t a**       | Add Stored Test      | Save the test under the cursor                |
| **ctrl-t shift+a** | Add Stored Test File | Save all tests in current file                |
| **ctrl-t s**       | Run Stored Test      | Run the stored test or test file              |
| **ctrl-t d**       | Delete Stored Test   | Clear the stored test                         |


**{VSCODE_ROOT}/User/keybindings.json**

_Keybindings are global so I use the same task names for projects regardless of language._

```json
[
    {
        "key": "ctrl+t t",
        "command": "workbench.action.tasks.runTask",
        "args": "Run All Tests"
    },
    {
        "key": "ctrl+t f",
        "command": "workbench.action.tasks.runTask",
        "args": "Test Current File"
    },
    {
        "key": "ctrl+t c",
        "command": "workbench.action.tasks.runTask",
        "args": "Run Current Test"
    },
    {
        "key": "ctrl+t a",
        "command": "workbench.action.tasks.runTask",
        "args": "Store Current Test"
    },
    {
        "key": "ctrl+t shift+a",
        "command": "workbench.action.tasks.runTask",
        "args": "Store Current Test File"
    },
    {
        "key": "ctrl+t s",
        "command": "workbench.action.tasks.runTask",
        "args": "Run Stored Test"
    },
    {
        "key": "ctrl+t d",
        "command": "workbench.action.tasks.runTask",
        "args": "Delete Stored Test"
    }
]

```

**{PROJECT_ROOT}/.vscode/tasks.json**

_I keep a copy of this in this in a folder with other Elixir-specific configuration files which I use across all projects.  I just copy & paste it into the '.vscode' folder when I create a new project._

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "phx.server",
            "type": "shell",
            "command": "iex -S mix phx.server"
        },
        {
            "label": "Run All Tests",
            "command": "mix test",
            "type": "shell",
            "group": "test",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            },
            "problemMatcher": [
                "$mixCompileError",
                "$mixCompileWarning",
                "$mixTestFailure"
            ]
        },
        {
            "label": "Run Current Test",
            "command": "mix test ${relativeFile}:${lineNumber}",
            "type": "shell",
            "group": "test",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            },
            "problemMatcher": [
                "$mixCompileError",
                "$mixCompileWarning",
                "$mixTestFailure"
            ]
        },
        {
            "label": "Test Current File",
            "command": "mix test ${relativeFile}",
            "group": "test",
            "type": "shell",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            },
            "problemMatcher": [
                "$mixCompileError",
                "$mixCompileWarning",
                "$mixTestFailure"
            ]
        },
        {
            "label": "Add Saved Test",
            "group": "test",
            "type": "shell",
            "command": "echo -n ${relativeFile}:${lineNumber} > ${workspaceRoot}/.vscode/STORED_TEST",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            }
        },
        {
            "label": "Add Saved File Test",
            "group": "test",
            "type": "shell",
            "command": "echo -n ${relativeFile} > ${workspaceRoot}/.vscode/STORED_TEST",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            }
        },
        {
            "label": "Delete Saved Test",
            "group": "test",
            "type": "shell",
            "command": "rm ${workspaceRoot}/.vscode/STORED_TEST",
            "presentation": {
                "echo": true,
                "reveal": "never",
                "focus": false,
                "panel": "shared"
            }
        },
        {
            "label": "Run Saved Test",
            "command": "mix test $(cat ${workspaceRoot}/.vscode/STORED_TEST)",
            "type": "shell",
            "group": "test",
            "problemMatcher": [
                "$mixCompileError",
                "$mixCompileWarning",
                "$mixTestFailure"
            ],
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            }
        }

    ]
}
```

I hope you found this post useful.  If you have any additional tips I'd love to hear about them in the comment area.
