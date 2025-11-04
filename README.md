# Claude Code System

> Personal Claude Code configuration collection for quick setup on new devices

A comprehensive toolkit that streamlines Claude Code configuration across multiple machines, featuring system-level development guidelines and automated installation of popular Claude Code tools.

---

## 🎯 Features

- ✅ **System-Level Configuration**: Standardized CLAUDE.md development guidelines
- ✅ **Tool Integration**: Easy installation of Claude Code ecosystem tools
- ✅ **Interactive Setup**: Choose which tools to install during setup
- ✅ **Backup Protection**: Optional backup of existing configuration
- ✅ **Quick Deploy**: One-command installation on new devices

---

## 🚀 Quick Start

```bash
# Clone the repository
git clone <repository-url>
cd claude-code-system

# Run installation
chmod +x install.sh
./install.sh
```

The installer will:
1. Install system-level `CLAUDE.md` to `~/.claude/CLAUDE.md`
2. Prompt you to install optional tools:
   - Claude Code Templates (100+ templates)
   - Claude Config Editor (config file cleanup tool)
   - SuperClaude Framework (meta-programming framework)

---

## 📁 Project Structure

```
claude-code-system/
├── README.md                           # Project documentation
├── install.sh                          # Main installation script
├── config/                             # Configuration files
│   └── CLAUDE.md                       # System-level development guidelines
└── tools/                              # Tool collection
    ├── claude-code-templates/
    │   ├── install.sh                  # Installation script
    │   └── README.md                   # Tool documentation
    ├── claude-config-editor/
    │   ├── install.sh
    │   └── README.md
    └── superclaude-framework/
        ├── install.sh
        └── README.md
```

---

## 🛠️ Included Tools

### Quick Comparison

| Tool | Type | Purpose | Token Cost | Typical Use Case |
|------|------|---------|------------|------------------|
| **System CLAUDE.md** | Required | Development guidelines | 0 | All projects |
| **Claude Code Templates** | Optional | 100+ ready-to-use templates | 0 | Project initialization, template reference |
| **Claude Config Editor** | Optional | Config file cleanup tool | 0 | Clean bloated config files |
| **SuperClaude Framework** | Optional | Meta-programming framework | 30-40K/task | Complex problem solving, deep research |

### Detailed Information

#### 1. System-Level CLAUDE.md
**Required** - Development guidelines and principles

Contains:
- Fail-Fast Principle
- Single Source of Truth
- Minimal Code Principle
- Communication Protocols
- Architecture Patterns

#### 2. Claude Code Templates *(Optional)*
**100+ ready-to-use templates**

- 48+ Agents (domain experts)
- 21+ Commands (slash commands)
- MCPs (external service integrations)
- Settings & Hooks

📚 [Details](tools/claude-code-templates/README.md)

#### 3. Claude Config Editor *(Optional)*
**Web-based configuration management**

- Visual interface for config cleanup
- Bulk project deletion (17 MB → 732 KB)
- MCP server management
- Auto-backup support

🔧 [Details](tools/claude-config-editor/README.md)

#### 4. SuperClaude Framework *(Optional)*
**Meta-programming configuration framework**

- 3 core plugins (PM Agent, Research, Index)
- 16 intelligent agents
- 7 operation modes
- 8 MCP server integrations

🧠 [Details](tools/superclaude-framework/README.md)

---

## 📖 Documentation

All documentation is contained in this README and individual tool documentation:
- **This README**: Project overview, quick start, tools comparison
- **Individual Tool Docs**: See `tools/<tool-name>/README.md` for detailed usage

---

## 🔧 Manual Tool Installation

If you skipped a tool during initial setup, you can install it manually:

```bash
# Install Claude Code Templates
./tools/claude-code-templates/install.sh

# Install Claude Config Editor
./tools/claude-config-editor/install.sh

# Install SuperClaude Framework
./tools/superclaude-framework/install.sh
```

---

## ⚠️ Important Notes

### Backup Recommendation

The installer will prompt you to backup existing `~/.claude/CLAUDE.md` if found. You can also backup manually:

```bash
cp ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.backup.$(date +%Y%m%d)
```

### Configuration Priority

- **System-level**: `~/.claude/CLAUDE.md` (applies to all projects)
- **Project-level**: `<project>/CLAUDE.md` (overrides system-level)

### What Gets Overwritten

Running the installer will overwrite:
- `~/.claude/CLAUDE.md` (with optional backup)

---

## 🎓 Usage

After installation:

1. **Restart Claude Code** to apply configuration changes

2. **Verify Installation**:
   ```bash
   ls -la ~/.claude/CLAUDE.md
   ```

3. **Explore Tools**:
   - Read individual tool READMEs for detailed usage

4. **Configure Tools**:
   - Follow tool-specific documentation
   - Customize as needed for your workflow

---

## 🤝 Contributing

This is a personal configuration collection, but suggestions are welcome:

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

---

## 📄 License

This project is for personal use. Individual tools have their own licenses:
- Claude Code Templates: MIT-compatible
- SuperClaude Framework: MIT
- Claude Code Workflows: MIT

---

## 🔗 Resources

- **Claude Code Official Docs**: https://docs.claude.com/claude-code

---

**Built with ❤️ for streamlined Claude Code setup**
