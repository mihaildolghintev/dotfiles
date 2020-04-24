if [[ ! -d $HOME/.zinit ]]; then
    print -P "Installing Plugin Manager (zdharma/zinit)…"
    command mkdir -p ~/.zinit
    command git clone https://github.com/zdharma/zinit ~/.zinit/bin && \\
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \\
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi


_set_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_set_cursor)

source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Plugins
zinit ice wait lucid
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/grep.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/compfix.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/directories.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/spectrum.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/history.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/completion.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/theme-and-appearance.zsh
zinit snippet OMZ::lib/key-bindings.zsh


zinit ice wait lucid pick'autopair.zsh' nocompletions
zinit light hlissner/zsh-autopair
zinit ice silent wait atload"!_zsh_autosuggest_start && bindkey '^ ' autosuggest-accept"
zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid atinit'zpcompinit; zpcdreplay'
zinit light zdharma/fast-syntax-highlighting
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

zinit ice wait:2 lucid
zinit light spwhitt/nix-zsh-completions
zinit ice wait:2 lucid
zinit light ninrod/pass-zsh-completion

zinit ice wait:2 lucid
zinit light zsh-users/zsh-history-substring-search
zinit ice wait:2 lucid
zinit light Tarrasch/zsh-bd
zinit ice wait:2 lucid
zinit light mafredri/zsh-async
zinit ice wait:2 lucid
zinit light ael-code/zsh-colored-man-pages
zinit ice wait:2 lucid
zinit light MichaelAquilina/zsh-auto-notify
zinit ice wait:2 lucid
zinit light wfxr/forgit
zinit ice wait:2 as"program" pick"tldr" lucid
zinit light raylee/tldr
zinit ice wait:2 lucid
zinit light soimort/translate-shell
zinit ice wait:2 lucid
zinit light zdharma/zui
zinit ice wait:2 lucid
zinit light zinit-zsh/zinit-console
zinit ice wait lucid
zinit light Aloxaf/fzf-tab
zinit ice wait lucid
zinit light chisui/zsh-nix-shell

zinit light trystan2k/zsh-tab-title
zinit light softmoth/zsh-vim-mode

# fzf
zinit ice wait lucid from"gh-r" as"program" atload"[ -f $ZDOTDIR/.fzf-keys.zsh ] && source $ZDOTDIR/.fzf-keys.zsh"
zinit light junegunn/fzf-bin


eval "$(starship init zsh)"
