#!/usr/bin/env python3
import gi
import subprocess
import signal
import os
import time

gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
from gi.repository import Gtk, AppIndicator3

### 🧩 CONFIGURAÇÃO PERSONALIZÁVEL ###
APP_EXECUTABLE = "AppFlowy"
APP_PROCESS_NAME = "AppFlowy"       # nome para `pgrep -f`
APP_WINDOW_CLASS = "appflowy"       # usado para identificar a janela (wmctrl -lx)
APP_ICON = "appflowy"               # ícone do sistema OU caminho absoluto ex: "/home/user/.icons/logo.png"
APP_TITLE = "AppFlowy-Tray"
#####################################

class GenericTrayApp:
    def __init__(self):
        self.indicator = AppIndicator3.Indicator.new(
            APP_TITLE,
            APP_ICON,
            AppIndicator3.IndicatorCategory.APPLICATION_STATUS
        )
        self.indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)
        self.indicator.set_menu(self.build_menu())

    def build_menu(self):
        menu = Gtk.Menu()

        toggle_item = Gtk.MenuItem(label=f"Open {APP_TITLE}")
        toggle_item.connect("activate", self.toggle_app)
        menu.append(toggle_item)

        quit_item = Gtk.MenuItem(label="Quit")
        quit_item.connect("activate", self.quit)
        menu.append(quit_item)

        menu.show_all()
        return menu

    def is_running(self):
        try:
            out = subprocess.check_output(["pgrep", "-f", APP_PROCESS_NAME])
            return out.decode().strip().split("\n")[0]
        except subprocess.CalledProcessError:
            return None

    def launch_app(self):
        subprocess.Popen([APP_EXECUTABLE], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        time.sleep(1)  # Aguarda a janela abrir
        self.minimize_window()

    def get_window_id(self):
        try:
            out = subprocess.check_output(["wmctrl", "-lx"]).decode()
            for line in out.splitlines():
                if APP_WINDOW_CLASS.lower() in line.lower():
                    return line.split()[0]
        except:
            return None
        return None

    def minimize_window(self):
        win_id = self.get_window_id()
        if win_id:
            subprocess.run(["wmctrl", "-i", "-r", win_id, "-b", "add,hidden"])

    def restore_window(self):
        win_id = self.get_window_id()
        if win_id:
            subprocess.run(["wmctrl", "-i", "-R", win_id])

    def toggle_app(self, _):
        if not self.is_running():
            self.launch_app()
        else:
            win_id = self.get_window_id()
            if win_id:
                subprocess.run(["wmctrl", "-i", "-R", win_id])

    def quit(self, _):
        Gtk.main_quit()

def main():
    signal.signal(signal.SIGINT, signal.SIG_DFL)
    tray = GenericTrayApp()
    Gtk.main()

if __name__ == "__main__":
    main()
