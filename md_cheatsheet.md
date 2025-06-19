# 🧠 Markdown Syntax & Cheatsheet (GitHub-Flavored)

A comprehensive overview of Markdown syntax with CommonMark + GitHub Flavored Markdown (GFM) extensions.

---

## 📁 Table of Contents

1. [Headings](#headings)
2. [Paragraphs and Line Breaks](#paragraphs-and-line-breaks)
3. [Text Formatting](#text-formatting)
4. [Lists](#lists)
5. [Blockquotes](#blockquotes)
6. [Links and Images](#links-and-images)
7. [Code](#code)
8. [Horizontal Rules](#horizontal-rules)
9. [Tables](#tables)
10. [HTML in Markdown](#html-in-markdown)
11. [Escaping Characters](#escaping-characters)
12. [Extended GitHub Features](#extended-github-features)
13. [Best Practices](#best-practices)

---

## 1. Headings

Use `#` followed by a space.

```markdown
# H1

## H2

### H3

#### H4

##### H5

###### H6
```

---

## 2. Paragraphs and Line Breaks

### Paragraphs

Separate by one or more blank lines.

```markdown
This is one paragraph.

This is another.
```

### Line Breaks

End a line with **two spaces** or use `<br>`:

```markdown
This line breaks here.  
New line.
```

Or:

```markdown
This breaks here.<br>Next line.
```

---

## 3. Text Formatting

```markdown
**Bold**
**Bold**

_Italic_
_Italic_

~~Strikethrough~~

**_Bold + Italic_**
**_Bold + Italic_**
```

---

## 4. Lists

### Unordered

```markdown
- Item

* Item

- Item
```

Nested:

```markdown
- Parent
  - Child
```

### Ordered

```markdown
1. First
2. Second
```

Auto-numbering allowed:

```markdown
1. Step one
1. Step two
```

### Task Lists (GFM)

```markdown
- [ ] Todo
- [x] Done
```

---

## 5. Blockquotes

```markdown
> This is a blockquote.
> It supports **Markdown**, lists, etc.

> ### Nested
>
> - Block
> - Quote
```

Nested levels:

```markdown
> Top level
>
> > Second level
> >
> > > Third level
```

---

## 6. Links and Images

### Links

```markdown
[Title](https://example.com)

[Title with hover](https://example.com "Hover text")
```

### Images

```markdown
![Alt text](https://example.com/image.png)

![Alt + title](https://example.com/image.png "Optional title")
```

---

## 7. Code

### Inline

```markdown
Use `backticks` for inline code.
```

### Fenced Code Blocks

Use triple backticks or tildes:

<pre>
```js
function greet() {
  console.log("Hello");
}
```
</pre>

### Indented Code Block (Legacy)

Indent with 4 spaces:

```
    legacy block
    still works
```

---

## 8. Horizontal Rules

```markdown
---

---

---
```

At least 3 of `-`, `*`, or `_`, on a new line.

---

## 9. Tables (GFM)

```markdown
| Column A | Column B | Column C |
| -------- | :------: | -------: |
| Left     |  Center  |    Right |
| A        |    B     |        C |
```

- `:--` = left aligned
- `:--:` = center aligned
- `--:` = right aligned

---

## 10. HTML in Markdown

You can embed raw HTML (not supported everywhere):

```html
<div style="color:red;">Red text</div>
<b>Bold via HTML</b>
```

---

## 11. Escaping Characters

Escape reserved Markdown symbols with a backslash:

```markdown
\*Not italic\*
\# Not a heading
```

Characters you can escape:

```
\   `   *   _   {}  []  ()  #  +  -  .  !
```

---

## 12. Extended GitHub Features (GFM)

### Collapsible Content

```html
<details>
  <summary>Click to expand</summary>

  Hidden content here.
</details>
```

### Emoji

```markdown
:smile: :rocket: :+1: :heart:
```

### Footnotes (if supported)

```markdown
This is a sentence with a footnote.[^1]

[^1]: This is the footnote text.
```

---

## 13. Best Practices

- Use fenced code blocks (` ``` `) and include language names for syntax highlighting.
- Use `-` for unordered lists consistently.
- Add spacing between headings and content.
- Keep tables aligned with spaces for readability.
- For complex formatting, mix Markdown and HTML carefully.
- Use preview mode or linting plugins like **markdownlint**.

---

## ✅ Markdown Tools

| Tool         | Use                               |
| ------------ | --------------------------------- |
| VSCode       | Great live preview and extensions |
| Obsidian     | Zettelkasten-style Markdown notes |
| Dillinger    | Browser-based Markdown editor     |
| Typora       | WYSIWYG-style Markdown editor     |
| markdownlint | Style enforcement and linting     |

---
