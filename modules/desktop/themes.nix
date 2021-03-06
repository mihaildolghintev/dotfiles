{ config, lib, pkgs, ... }:

{
  my.home.gtk.enable = true;
  my.home.gtk = {
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };
    theme = {
      package = pkgs.gnome3.gnome_themes_standard;
      name = "Adwaita-dark";
    };
    gtk3 = {
      extraConfig = {
        gtk-decoration-layout = "appmenu:none";
        gtk-cursor-theme-name = "Adwaita";
        gtk-cursor-theme-size = 0;
      };
      extraCss = ''
        * { outline: none; }
      '';
    };
  };

  qt5 = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  my.home.home.file.".Xresources".source = <config/xresources/.Xresources>;
}
