# dotfiles

使用 Git 管理的个人开发环境配置。

## 包含内容

- **opencode**：AI 编程 Agent 配置，以及 `oh-my-opencode-slim` 的模型路由配置。
- **Ghostty**：终端字体、主题、透明度、滚动行为和 macOS 按键行为配置。
- **Neovim**：基于 Lua 的编辑器配置，包含插件、LSP、Telescope、Treesitter、Git signs、测试和终端集成。
- **tmux**：前缀键、快捷键、面板、鼠标支持、Catppuccin 主题和 TPM 插件配置。

纳入版本管理的路径：

- `.config/opencode`
- `.config/ghostty`
- `.config/nvim`
- `.tmux.conf`

## 快速上手

克隆仓库：

```bash
git clone git@github.com:mrcfps/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
```

安装软链接到 `$HOME`：

```bash
./install.sh
```

安装时，如果目标位置已存在配置，会先移动到：

```text
~/.dotfiles-backup/<timestamp>/
```

然后再创建指向本仓库的软链接。

## 工具说明

### opencode

配置位置：

```text
~/.config/opencode
```

主要文件：

- `opencode.json`：opencode 基础配置。
- `oh-my-opencode-slim.json`：orchestrator 和各子 Agent 的模型路由配置。
- `tui.json`：终端 UI 设置。

配置中的 API Key 通过环境变量读取，例如：

```bash
export OPENROUTER_API_KEY="..."
```

本地 npm/bun 状态文件、lockfile、运行状态、备份文件和机器本地 skill 软链接不会纳入版本管理。

### Ghostty

配置位置：

```text
~/.config/ghostty/config
```

主要特性：

- JetBrains Mono Nerd Font + PingFang SC 中文字体 fallback。
- Catppuccin Mocha 主题。
- 半透明背景。
- macOS 下 Option 作为 Alt 使用。
- 对 tmux / Neovim 友好的终端设置。

### Neovim

配置位置：

```text
~/.config/nvim
```

入口文件：

```text
~/.config/nvim/init.lua
```

常用功能：

- 使用 `lazy.nvim` 管理插件。
- LSP 和 Mason 配置。
- Telescope 搜索辅助函数。
- Treesitter 语法支持。
- Git signs 和 Trouble 诊断列表。
- ToggleTerm 终端集成。
- Which-key leader 快捷键提示。

启动 Neovim：

```bash
nvim
```

### tmux

配置位置：

```text
~/.tmux.conf
```

主要特性：

- Prefix：`Ctrl-Space` / `C-@`。
- 分屏：
  - `prefix |`：左右分屏。
  - `prefix -`：上下分屏。
- Vim 风格面板导航：`prefix h/j/k/l`。
- 重新加载配置：`prefix r`。
- Catppuccin 主题和 TPM 插件。

首次启动 tmux 后安装插件：

```text
prefix + I
```

## 更新配置流程

安装后，`~/.config/...` 和 `~/.tmux.conf` 都会软链接到本仓库。因此直接修改日常使用中的配置文件，就等于修改了仓库里的文件。

提交并推送改动：

```bash
cd ~/Projects/dotfiles
git status
git add .
git commit -m "Update dotfiles"
git push
```

## 卸载

移除软链接，并在存在备份时恢复最近一次备份：

```bash
./uninstall.sh
```

## 说明

- 备份会保存在 `~/.dotfiles-backup/<timestamp>/`。
- 如果软链接已经正确存在，重复执行 `install.sh` 是安全的。
- 密钥应保存在环境变量中，不要提交到配置文件里。
