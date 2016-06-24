# Directory definitions
TEMPLATE_DIR = templates
SASS_DIR = sass
CSS_DIR = stylesheets
JS_DIR = js
ASSET_DIR = assets
BUILD_DIR = build

# File list and build file definitions

# Specify compiled html files here in the order they should be concatenated in the final file
# Don't include head.html, it's added separately
_HTML_FILES = afterparty.html
HTML_PATHS = $(patsubst %,$(TEMPLATE_DIR)/%/,$(basename $(_HTML_FILES)))
HTML_FILES = $(join $(HTML_PATHS), $(_HTML_FILES))
HEAD = $(TEMPLATE_DIR)/head/head.html
HTML_BUILD = $(BUILD_DIR)/index.html
EMPTY_STRING :=
HTML_INDENT := $(EMPTY_STRING)    # Four spaces

JS_FILES = $(wildcard $(JS_DIR)/*.js)
JS_BUILD = $(BUILD_DIR)/script.js

SASS_FILES = $(wildcard $(SASS_DIR)/*.scss)
CSS_BUNDLE = style.css
COMPASS_OUTPUT = $(CSS_DIR)/$(CSS_BUNDLE)
CSS_BUILD = $(BUILD_DIR)/$(CSS_BUNDLE)

ASSET_FILES = $(shell find $(ASSET_DIR))
ASSET_BUILD = $(subst $(ASSET_DIR),$(BUILD_DIR),$(ASSET_FILES))

# Testing for necessary programs
COMPASS := $(shell command -v compass 2> /dev/null)
MUSTACHE := $(shell command -v mustache 2> /dev/null)

ifndef COMPASS
$(error Compass is not available. Make sure it is installed)
endif

ifndef MUSTACHE
$(error Mustache is not available. Make sure it is installed)
endif

# Targets
site: $(BUILD_DIR) $(HTML_BUILD) $(CSS_BUILD) $(JS_BUILD) $(ASSET_BUILD)

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

# Hacky code to indent HTML with sed
$(HTML_BUILD): $(HEAD) $(HTML_FILES)
	printf "<!DOCTYPE html>\n<html>\n" > $(HTML_BUILD)
	cat $(HEAD) | sed 's/^/${HTML_INDENT}/' >> $(HTML_BUILD)
	printf "${HTML_INDENT}<body>\n" >> $(HTML_BUILD)
	cat $(HTML_FILES) | sed 's/^/${HTML_INDENT}${HTML_INDENT}/' >> $(HTML_BUILD)
	printf "${HTML_INDENT}</body>\n" >> $(HTML_BUILD)
	printf "</html>\n" >> $(HTML_BUILD)

%.html: %.yaml %.mustache
	mustache -e $^ > $@

$(CSS_BUILD): $(SASS_FILES)
	compass compile
	cp $(COMPASS_OUTPUT) $(CSS_BUILD)

$(JS_BUILD): $(JS_FILES)
	cat $(JS_FILES) > $(JS_BUILD)

$(BUILD_DIR)/%: $(ASSET_DIR)/%
	cp -r $< $@

.PHONY: clean

clean:
	rm -rf $(BUILD_DIR)
	find $(TEMPLATE_DIR) -type f -name '*.html' -exec rm {} +
	compass clean
	rmdir $(CSS_DIR)
