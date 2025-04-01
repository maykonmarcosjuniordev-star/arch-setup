# https://aur.archlinux.org/packages/python-orange
# https://biolab.github.io/install-orange/#lin

all:
	git clone https://github.com/biolab/orange3
	cd orange3
	python -m venv ~/.reps/orange
	source ~/.reps/orange3/orange/bin/activate
	pip install -r requirements.txt
	pip install -r requirements-gui.txt
	pip install -r requirements-sql.txt
	pip install -r requirements-core.txt
	pip install -r requirements-dev.txt
	pip install -r requirements-pyqt.txt
	pip install -r requirements-readthedocs.txt
	pip install setuptools trubar
	python setup.py develop
	cd ..
	git clone https://github.com/biolab/orange-bio
	cd orange-bio
	python setup.py develop

	#git clone https://aur.archlinux.org/python-orange.git
	#cd python-orange/
	#sudo pacman -Suy python-yaml python-pyqt5-webengine
	#pip install chardet pyqtgraph xlrd scikit-learn joblib keyrings-alt bottleneck xlsxwriter networkx matplotlib pandas openpyxl httpx scipy pygments qtconsole anyqt serverfiles opentsne orange-widget-base orange-canvas-core baycomp requests-cache python-louvain
 	#makepkg -sirc
	#git clean -dfx
	#pip install PyQt5 PyQtWebEngine
	#sudo pacman -Suy python-pyqt5.qtsvg
	pip install orange3

clean:
	#deactivate
	#sudo rm -rd ~/.reps/orange/
