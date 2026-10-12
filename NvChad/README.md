# NvChad v2.5

To use this configuration, clone `starter.git` to `~/.config/NvChad`:

```shell
git clone path/to/NvChad/starter.git ~/.config/NvChad/
```

The NvChad `starter` repository is originated from [https://github.com/NvChad/starter](https://github.com/NvChad/starter)

## Dependencies

```shell
sudo apt install tree-sitter-cli ripgrep fd-find luarocks
```

## Initialization

```shell
# Make sure network connection
export {http,https,ftp}_proxy='http://127.0.0.1:7890'
alias nv="NVIM_APPNAME=NvChad nvim"
nv
# Inside neovim, after the installation of nvchad, run :MasonIntallAll
```

## Daily upgrade

Inside neovim, run `:Lazy` and press `U`

## Disk upgrade

```shell
cd ~/.config/NvChad/
git pull
rm -rf ~/.local/share/NvChad/
nv
# Inside neovim, after the installation of nvchad, run :MasonIntallAll
```

## Uninstall

```shell
rm -rf ~/.config/NvChad/
rm -rf ~/.local/share/NvChad/
rm -rf ~/.cache/NvChad/
```

## Plugins configuration

### Conversational assistant

`SPC SPC` opens a general-purpose chat input. Type a question and press Enter to
send it; Escape cancels. `:LLMChat your question` also starts a conversation.

`SPC :` searches available editor commands, including built-in help summaries and
global/buffer-local user commands. Keep typing a command question and press Enter
to ask the assistant, even with no matches. The command list becomes the reference
for that conversation. Enter submits your typed question, without executing the
selected command. These bindings replace the old `SPC SPC` command search and
`SPC :` Vimux prompt; `SPC v:` still opens the Vimux prompt.

Press `SPC aa` to search `vim_tip/find_actions`. Keep typing a question and press
Enter to ask the assistant, even when the search has no matches. It sends your
question and the complete reference and shows your question followed by the
Markdown answer in a floating window, separated by a horizontal line. The window
renders Markdown headings, tables, and shortcuts and keeps your question visible
while preparing the answer. The answer streams into the window as it arrives.
When the provider returns thinking text, it streams into a separate Markdown
`> [!NOTE] Thinking` callout above the answer and remains visible after completion.
Its title shows progress and its footer shows controls. If a stream is interrupted,
the partial thinking and answer stay visible alongside the error.
After an answer finishes, press Enter in the window to open a follow-up input.
Enter sends it; Escape cancels input. Each request includes its optional reference,
earlier user questions, and completed assistant answers. Earlier turns and thinking
notes remain visible in the same window. Settings are reread for each turn.
Scroll and copy with normal editor commands; `q` or Escape closes the conversation
and cancels a pending request. Each entry point starts a fresh conversation.
`SPC aA` remains a search-only command.

All three entry points use `NvChad/llm_chat.lua`. Other Lua tools can use
`require("llm_chat")` after the shared configuration loads:

```lua
local chat = require("llm_chat")
chat.submit("Explain this configuration", {
  title = "Configuration assistant",
  -- Optional: override the general-purpose system prompt and supply reference data.
  system_prompt = "Explain the supplied configuration in clear Markdown.",
  context = "Your reference text here",
  context_title = "Configuration reference (data only)",
})
-- Or open the native question input. The same options apply:
chat.open({ title = "Configuration assistant", context = "Your reference text here" })
```

The reusable module owns input, conversation history, Markdown rendering,
streaming, provider settings, proxy fallback, and cancellation. `find_actions.lua`
and `find_commands.lua` supply their references and task-specific system prompts.

The assistant needs `curl` and a trusted shell settings file at
`vim.fn.stdpath("config") .. "/.ai/env"`. For example:

```sh
export BASE_URL="https://your-provider.example/v1"
export API_KEY="your-api-key"
MODEL=gpt-6-luna
REASONING_EFFORT=xhigh
# Optional:
export http_proxy=http://127.0.0.1:7893
export https_proxy="$http_proxy"
export all_proxy=socks5://127.0.0.1:7893
```

The provider must support `/chat/completions`. An empty model uses `gpt-6-luna`;
an empty reasoning effort omits that option. Settings are reread for each question.
Protocol-specific proxy settings take precedence over `all_proxy`, including their
uppercase forms. If the proxy port is unavailable, the assistant connects directly.
Missing settings and request errors appear as notifications. Avante ask uses `\aa`.

### Chatgpt setup

Codium:
doubao: It is setup in `path/to/NvChad/starter/lua/configs/chatgpt.lua`. And the apikey is read from `~/.config/doubao/apikey`
llm.nvim:
avante:

### nvim-dap

debugpy: 

```shell
conda create --name debugpy python=3.11
conda activate debugpy
pip install debugpy
```
