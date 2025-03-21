# Neovim Plugin Configuration Progress

## Priority Order

1. [x] **lsp.lua**

   - Core language server protocol configuration.
   - Provides intelligent code completion, diagnostics, and navigation.<br><br>

2. [x] **cmp.lua**

   - Completion engine.
   - Works with LSP, snippets, and custom sources for autocompletion.<br><br>

3. [x] **toggleterm.lua**

   - Integrated terminal management.
   - Enhances terminal workflows with persistent splits and better navigation.<br><br>

4. [ ] **treesitter.lua**

   - Advanced syntax highlighting and code structure understanding.
   - Improves visuals and editing experience.<br><br>

5. [ ] **mason.lua**

   - Plugin manager for LSP, DAP, formatters, and linters.
   - Simplifies setup for external tools.<br><br>

6. [ ] **nvim-dap.lua** and **dap-ui.lua**

   - Debugging framework and UI for Neovim.
   - Adds interactive debugging support for various languages.<br><br>

7. [ ] **telescope.lua**

   - Fuzzy finder for files, projects, and content.
   - Highly customizable and integrates with many extensions.<br><br>

8. [ ] **lualine.lua**

   - Statusline customization plugin.
   - Can display LSP status, git info, and other metrics.<br><br>

9. [ ] **bufferline.lua**

   - Buffer/tab management plugin.
   - Adds icons and enhanced navigation between open files.<br><br>

10. [ ] **neo-tree.lua**

    - File explorer replacement.
    - Provides a modern UI with icons and customizable behaviors.<br><br>

11. [ ] **git-signs.lua** and **fugitive.lua**

    - Git integration plugins.
    - Adds inline git information and command shortcuts.<br><br>

12. [ ] **treesitter-context.lua**

    - Displays the current code context at the top of the window.
    - Useful for working with deeply nested code.<br><br>

13. [ ] **treesitter-textobjects.lua**

    - Enhances text navigation with Treesitter-powered objects.
    - Allows precise movements and selections in code.<br><br>

14. [ ] **dashboard.lua**

    - Start screen plugin.
    - Customize your Neovim launch experience with shortcuts and aesthetics.<br><br>

15. [ ] **zen-mode.lua**

    - Distraction-free coding environment.
    - Hides UI elements for focused work.<br><br>

16. [ ] **autopairs.lua**

    - Automatically closes brackets and quotes.
    - Simplifies typing paired characters.<br><br>

17. [ ] **comment.lua**

    - Streamlines code commenting.
    - Provides shortcuts for toggling comments.<br><br>

18. [ ] **harpoon.lua**

    - Bookmarking and navigation plugin.
    - Helps manage frequently accessed files and locations.<br><br>

19. [ ] **indent-blanklines.lua**

    - Displays vertical indentation guides.
    - Improves code readability, especially for nested blocks.<br><br>

20. [ ] **leap.lua**

    - Motion plugin for fast navigation.
    - Jump to locations in files with minimal keystrokes.<br><br>

21. [ ] **notify.lua**

    - Custom notification system.
    - Replaces default Neovim messages with styled popups.<br><br>

22. [ ] **oil.lua**

    - File and directory explorer.
    - Simplifies file operations within Neovim.<br><br>

23. [ ] **persistence.lua**

    - Session management plugin.
    - Automatically saves and restores working sessions.<br><br>

24. [ ] **project.lua**

    - Project management and navigation.
    - Simplifies switching between projects and configurations.<br><br>

25. [ ] **rainbow-delimiters.lua**

    - Highlights matching parentheses with colors.
    - Improves visual clarity in nested code structures.<br><br>

26. [ ] **refactoring.lua**

    - Refactoring tools for various languages.
    - Adds shortcuts for common refactoring operations.<br><br>

27. [ ] **symlink.lua**

    - Handles symbolic links efficiently.
    - Useful for managing linked files and projects.<br><br>

28. [ ] **template-string.lua**

    - Enhances handling of template strings in code.
    - Useful for dynamic string manipulation.<br><br>

29. [ ] **todo-comments.lua**

    - Highlights TODOs, FIXMEs, and similar annotations.
    - Adds a searchable list of tasks and notes in code.<br><br>

30. [ ] **ts-autotag.lua**

    - Automatically closes and renames HTML tags.
    - Integrates with Treesitter for contextual behavior.<br><br>

31. [ ] **ts-comment-string.lua**

    - Context-aware commenting for Treesitter-supported languages.
    - Ensures the correct comment format is used in different contexts.<br><br>

32. [x] **friendly-snippets.lua**

    - Predefined snippets for various languages.
    - Works with completion plugins for enhanced productivity.<br><br>

33. [ ] **peek.lua**

    - Live preview for Markdown files.
    - Useful for writing documentation and content.<br><br>

34. [ ] **fidget.lua**

    - LSP progress indicator.
    - Displays activity for background LSP tasks.<br><br>

35. [ ] **emmet.lua**

    - Emmet support for HTML and CSS.
    - Speeds up frontend development workflows.<br><br>

36. [ ] **luarocks.lua**

    - Lua package manager integration.
    - Allows installing and managing Lua dependencies<br><br>

37. [ ] **navic.lua**

    - Provides code context (breadcrumbs).<br><br>

38. [ ] **inc-rename.lua**

    - Enhances rename operations in LSP.<br><br>

39. [ ] **lspsaga.lua**

    - Enhances LSP UX with features like floating windows, symbol outline, and more.<br><br>

40. [ ] **lightbulb.lua**
    - Adds a lightbulb UI element indicating code actions.<br><br>

---

## Completed

---

## All installed plugins to be configured

- autopairs.lua
- bufferline.lua
- comment.lua
- dap-ui.lua
- dashboard.lua
- emmet.lua
- fidget.lua
- fugitive.lua
- git-signs.lua
- harpoon.lua
- indent-blanklines.lua
- leap.lua
- lualine.lua
- luarocks.lua
- peek.lua
- mason.lua
- neo-tree.lua
- notify.lua
- nvim-dap.lua
- oil.lua
- persistence.lua
- project.lua
- rainbow-delimiters.lua
- refactoring.lua
- symlink.lua
- telescope.lua
- template-string.lua
- todo-comments.lua
- toggleterm.lua
- treesitter-context.lua
- treesitter-textobjects.lua
- treesitter.lua
- trouble.lua
- ts-autotag.lua
- ts-comment-string.lua
- which-key.lua
- zen-mode.lua
- navic.lua
- inc-rename.lua
- lspsaga.lua
- lightbulb.lua
- ufo.lua

---

### Main List (Recommended Install Order)

- consider TimUntersberger/neogit to replace tpope/vim-fugitive

- Add kevinhwang91/nvim-ufo
