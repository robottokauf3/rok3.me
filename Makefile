THEME_DIR = themes/rok3/

SASS_DIR = $(THEME_DIR)assets/styles/
STYLES_DIR = $(THEME_DIR)static/css/
SASS_INPUT_FILE = main.scss
SASS_OUTPUT_FILE = main.css
SASS_BASE_COMMAND = sass $(SASS_DIR)$(SASS_INPUT_FILE):$(STYLES_DIR)$(SASS_OUTPUT_FILE)

build:
	$(SASS_BASE_COMMAND) --style expanded

build-prod:
	$(SASS_BASE_COMMAND) --style compressed --sourcemap=none

watch:
	$(SASS_BASE_COMMAND) --watch --style expanded

clean:
	rm -rf static/css/* .sass-cache/
