SHELL := /bin/bash
ARGS = $(filter-out $@,$(MAKECMDGOALS))

BIN_PHP = $(shell which php)
BIN_PYTHON2 = $(shell which python)
BIN_PYTHON3 = $(shell which python3)

SERVE_PORT = 8000
SERVE_DIR = .

default: link serve

git:
	make
	git add . && git commit -m "Experimental" && git push

link:
	@rm -f dist && ln -s front/dist/ dist

serve:
	@if [ $(BIN_PYTHON3) ] ; then \
		python3 -m http.server -d $(SERVE_DIR) $(SERVE_PORT) ; \
	elif [ $(BIN_PYTHON2) ] ; then \
		python -m SimpleHTTPServer -d $(SERVE_DIR) $(SERVER_PORT) ; \
	elif [ $(BIN_PHP) ] ; then \
		php -S localhost:$(SERVE_PORT) -t $(SERVE_DIR) ; \
	fi;

#: This help.
help:
	@grep -B1 -E "^[%a-zA-Z0-9_-]+\:([^\=]|$$)" Makefile \
	| grep -v -- -- \
	| sed 's/%/:/g' \
	| sed 'N;s/\n/###/' \
	| sed -n 's/^#: \(.*\)###\(.*\):.*/\2###\1/p' \
	| column -t -s '###' \

%:
	@:
