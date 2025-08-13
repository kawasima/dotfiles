# Java Development Setup for Emacs 30

## Prerequisites

### 1. Install Eclipse JDT Language Server (jdtls)

**macOS (Homebrew):**
```bash
brew install jdtls
```

**Manual Installation:**
1. Download from: https://download.eclipse.org/jdtls/snapshots/latest.tar.gz
2. Extract to a directory (e.g., `~/.local/share/jdtls`)
3. Add the `bin` directory to your PATH

### 2. Install Google Java Format (optional)

```bash
# macOS
brew install google-java-format

# Or download JAR
wget https://github.com/google/google-java-format/releases/download/v1.19.1/google-java-format-1.19.1-all-deps.jar
```

### 3. Install Tree-sitter Grammar for Java (Emacs 30)

In Emacs:
```elisp
M-x treesit-install-language-grammar RET java RET
```

## Configuration Overview

The new `init-java.el` provides:

- **LSP Support**: Using Eglot (built-in to Emacs 29+) with jdtls
- **Tree-sitter**: Enhanced syntax highlighting for Emacs 30
- **Project Detection**: Automatic Maven/Gradle project recognition
- **Code Formatting**: Google Java Format integration
- **Debugging**: DAP mode for debugging Java applications
- **Testing**: Quick test execution at point or for entire project

## Key Bindings

| Key       | Function                          |
|-----------|-----------------------------------|
| `C-c j i` | Organize imports                  |
| `C-c j r` | Rename symbol                     |
| `C-c j f` | Format buffer                     |
| `C-c j t` | Run test at point                 |
| `C-c j T` | Run all tests                     |
| `C-c j c` | Compile project                   |
| `C-c j d` | Start debugger                    |

## Troubleshooting

### jdtls not starting

1. Check if jdtls is in PATH: `which jdtls`
2. Check Eglot events buffer: `M-x eglot-events-buffer`
3. Ensure Java 11+ is installed: `java -version`

### Tree-sitter not working

1. Verify tree-sitter support: `M-: (treesit-available-p)`
2. Install grammar if needed: `M-x treesit-install-language-grammar`

### Formatter not working

1. Install google-java-format as described above
2. Check if executable is in PATH
3. Disable with: `M-x google-java-format-on-save-mode`