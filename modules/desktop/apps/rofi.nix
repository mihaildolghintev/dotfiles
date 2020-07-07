{ config, options, lib, pkgs, ... }:

with lib;
let cfg = config.modules.desktop.apps.rofi;
in {
  options.modules.desktop.apps.rofi = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    my.home.programs = {
      rofi = {
        enable = true;
        lines = 10;
        scrollbar = true;
        cycle = true;
        theme = "gruvbox-dark-hard";
        extraConfig = ''
          rofi.modi: drun
          rofi.show-icons: true
        '';
      };
    };

    my.packages = with pkgs; [
      (makeDesktopItem {
        name = "reboot";
        desktopName = "System: Reboot";
        icon = "system-reboot";
        exec = "systemctl reboot";
      })
      (makeDesktopItem {
        name = "shutdown";
        desktopName = "System: Shut Down";
        icon = "system-shutdown";
        exec = "systemctl shutdown";
      })
      (makeDesktopItem {
        name = "sleep";
        desktopName = "System: Sleep";
        icon = "system-suspend";
        exec = "${<bin/zzz>} -f";
      })
      (makeDesktopItem {
        name = "lock-display";
        desktopName = "Lock screen";
        icon = "system-lock-screen";
        exec = "${<bin/zzz>}";
      })
    ];
  };

}
