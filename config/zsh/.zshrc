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
## Snippets

zinit wait lucid light-mode for \
        OMZP::sudo/sudo.plugin.zsh \
        OMZP::git-auto-fetch/git-auto-fetch.plugin.zsh \
        OMZL::grep.zsh \
        OMZL::compfix.zsh \
        OMZL::directories.zsh \
        OMZL::spectrum.zsh \
        OMZL::history.zsh \
        OMZL::completion.zsh \
        OMZL::theme-and-appearance.zsh

zinit light-mode for \
        OMZL::key-bindings.zsh \
        OMZL::termsupport.zsh \

## In turbo mode
zinit wait lucid light-mode for \
        Aloxaf/fzf-tab \
        zsh-users/zsh-history-substring-search \
        Tarrasch/zsh-bd \
        mafredri/zsh-async \
        ael-code/zsh-colored-man-pages \
        MichaelAquilina/zsh-auto-notify \
        wfxr/forgit \
        soimort/translate-shell \
        zdharma/zui \
        zinit-zsh/zinit-console \
        chisui/zsh-nix-shell \
    as"program" \
        pick"tldr" raylee/tldr \
    as"completion" \
        OMZP::docker/_docker \
        spwhitt/nix-zsh-completions \
        ninrod/pass-zsh-completion \


## light
zinit light-mode for \
       softmoth/zsh-vim-mode \

# fzf
zinit wait lucid from"gh-r" as"program" \
      atload"[ -f $ZDOTDIR/.fzf-keys.zsh ] && source $ZDOTDIR/.fzf-keys.zsh" for \
               junegunn/fzf-bin



zinit wait lucid light-mode for \
    pick'autopair.zsh' nocompletions \
        hlissner/zsh-autopair \
    silent atload"!_zsh_autosuggest_start && bindkey '^ ' autosuggest-accept" \
        zsh-users/zsh-autosuggestions \
    atinit'zpcompinit; zpcdreplay' \
        zdharma/fast-syntax-highlighting
# Recommended Be Loaded Last.
zinit ice wait blockf lucid atpull'zinit creinstall -q .'
zinit load zsh-users/zsh-completions


eval "$(starship init zsh)"

source $XDG_CONFIG_HOME/zsh/br

## Auto-generated by my nix config
source $ZDOTDIR/extra.zshrc

