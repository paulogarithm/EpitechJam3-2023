#-#-#-#-#-#-#-#-#-#-#-#-#
#                       #
#   Epitech Jam  2023   #
#                       #
#-#-#-#-#-#-#-#-#-#-#-#-#

CHECK_LOVE := $(shell which love >/dev/null 2>&1; echo $$?)
OS := $(shell uname -s)
PACKAGE_MANAGER := $(shell which apt >/dev/null 2>&1 && echo "apt" \
	|| which brew >/dev/null 2>&1 && echo "brew" \
	|| which dnf >/dev/null 2>&1 && echo "dnf")

all:
	@if [ $(CHECK_LOVE) = 0 ]; then\
		love src/;\
	else\
		$(MAKE) install_love;\
	fi

install_love:
	@echo "Installation de LÖVE..."
	@if [ "$(OS)" = "Linux" ]; then\
		sudo $(PACKAGE_MANAGER) install love; \
	elif [ "$(OS)" = "MacOS" ]; then\
		$(PACKAGE_MANAGER) install love;\
	else\
		echo "Impossible de déterminer le gestionnaire de paquets pour installer 'love'.";\
	fi
