# https://support.mozilla.org/en-US/kb/customizing-firefox-using-autoconfig
# https://support.mozilla.org/en-US/kb/keyboard-shortcuts-perform-firefox-tasks-quickly?redirectslug=Keyboard+shortcuts&redirectlocale=en-US
# https://superuser.com/questions/1271147/change-key-bindings-keyboard-shortcuts-in-firefox-57
#TODO: setting of config files
all:
	mkdir -p ~/.mozilla/firefox/abc123.default-release/chrome
	ln -sf ~/arch-setup/config/firefox/user.js ~/.mozilla/firefox/*.default/user.js
	ln -sf ~/arch-setup/config/firefox/userChrome.css ~/.mozilla/firefox/*.default/chrome/userChrome.css
