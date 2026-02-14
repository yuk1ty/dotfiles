# AI Assisted Coding Rules

<!-- CREDIT: basically from https://gist.github.com/masakielastic/a82375bd55266a44bc1a386f19d7522b and customised a bit -->

### Basic Policy

For code analysis, search, and refactoring tasks, prioritize using **ast-grep** over text-based tools (grep, sed, awk, etc.).

### When ast-grep Usage is Required

#### 1. Code Search & Analysis

- Searching for function definitions
- Extracting syntax elements with specific patterns
- Identifying API usage locations
- Analyzing dependencies

```bash
# Recommended: Syntactically accurate search
ast-grep --pattern 'function $NAME($$$) { $$$ }'

# Not recommended: Text-based search
grep "function.*(" *.js
```

#### 2. Refactoring Tasks

- Batch renaming of functions and variables
- Changing API call formats
- Unifying syntax patterns
- Replacing deprecated features

```bash
# Recommended: Syntax-aware replacement
ast-grep --pattern 'console.log($MSG)' --rewrite 'logger.info($MSG)'

# Not recommended: String replacement
sed 's/console.log/logger.info/g'
```

#### 3. Code Quality Checks

- Detecting specific anti-patterns
- Identifying security vulnerabilities
- Detecting coding standard violations

### Implementation Guidelines

#### Utilizing Pattern Files

Write complex search/replace patterns in configuration files:

```yaml
# .ast-grep/rules/deprecated-api.yml
id: replace-deprecated-api
message: Replace deprecated API call
severity: warning
language: JavaScript
rule:
  pattern: oldApi.method($$$)
fix: newApi.method($$$)
```

#### Language Support

ast-grep supports the following languages:

- JavaScript/TypeScript
- Python
- Rust
- Go
- Java
- Kotlin
- C/C++
- Many others

Leverage language-specific syntax understanding for more precise operations.

### Prohibited Uses

Avoid using text-based tools in the following scenarios:

- Searching for syntax elements (functions, classes, variables, etc.)
- Refactoring that changes program structure
- Analysis tasks requiring code semantic understanding

### Exceptions for Text-Based Tools

- Processing configuration files (JSON, YAML, etc.)
- Parsing log files
- Editing documentation (Markdown, etc.)
- Working with languages not supported by ast-grep

### Performance Considerations

When working with large codebases:

- Limit scope with appropriate file patterns
- Utilize parallel processing options
- Consider incremental processing

### Quality Assurance

After making changes with ast-grep, always:

- Check for syntax errors
- Run the test suite
- Review the changed code sections

### Learning Resources

- [ast-grep Official Documentation](https://ast-grep.github.io/)
- Understanding pattern matching syntax
- Grasping language-specific AST structures

---

**Important**: Following these guidelines enables safer and more accurate code operations, preventing unintended side effects and syntax errors.
