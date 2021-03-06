{ config, options, lib, pkgs, ... }:

with lib;
with import <home-manager/modules/lib/dag.nix> { inherit lib; }; {
  options.modules.editors.emacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.editors.emacs.enable {
    my = {
      packages = with pkgs; [
        emacs
        ## Doom dependencies
        git
        (ripgrep.override { withPCRE2 = true; })

        ## Optional dependencies
        editorconfig-core-c # per-project style config
        fd # faster projectile indexing
        gnutls # for TLS connectivity
        imagemagick # for image-dired
        (lib.mkIf (config.programs.gnupg.agent.enable)
          pinentry_emacs) # in-emacs gnupg prompts
        zstd # for undo-tree compression

        ## Module dependencies
        # :checkers spell
        aspell
        aspellDicts.en
        aspellDicts.en-computers
        aspellDicts.en-science
        # :checkers grammar
        languagetool
        # :tools lookup
        sqlite
        # :lang markdown previews
        python37Packages.grip
        # :lang latex & :lang org (latex previews)
        texlab
        texlive.combined.scheme-full # FULL
      ];

      env.PATH = [ "$HOME/.emacs.d/bin" ];
    };

    ## Decided to use just emacs
    # services.emacs = {
    #   enable = true;
    #   defaultEditor = true;
    # };

    # Emacs-doom config
    ##  to change config and dont rebuild all nixos
    my.home.home.activation.linkDoomConfig =
      dagEntryAfter [ "writeBoundary" ] ''
        [ -d $HOME/.doom.d ] || ln -sf "$HOME/.dotfiles/config/doom" $HOME/.doom.d
        [ -d $HOME/.emacs.d ] || git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
      '';

    fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];
  };
}
