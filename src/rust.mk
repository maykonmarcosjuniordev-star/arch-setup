all:
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh

update:
	rustup update

clean:
	rustup self uninstall
