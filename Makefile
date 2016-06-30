# Directory definitions
TEMPLATE_DIR := templates
SASS_DIR := sass
JS_DIR := js
ASSET_DIR := assets
WATCH_DIRS := $(TEMPLATE_DIR) $(SASS_DIR) $(JS_DIR) $(ASSET_DIR)
BUILD_DIR := build

# File list and build file definitions

# Specify compiled html files here in the order they should be concatenated in the final file
# Don't include head.html, it's added separately
HTML_FILES := afterparty.html
HTML_PATHS := $(patsubst %,$(TEMPLATE_DIR)/%/,$(basename $(HTML_FILES)))
HTML_FILES := $(join $(HTML_PATHS), $(HTML_FILES))
HEAD := $(TEMPLATE_DIR)/head/head.html
HTML_BUILD := $(BUILD_DIR)/index.html
EMPTY_STRING :=
HTML_INDENT := $(EMPTY_STRING)    # Four spaces

JS_FILES := $(wildcard $(JS_DIR)/*.js)
JS_BUILD := $(BUILD_DIR)/script.js
LIVEJS := $(JS_DIR)/live.js
ifndef WATCHING
JS_FILES := $(filter-out $(LIVEJS),$(JS_FILES))
endif

SASS_FILES := $(wildcard $(SASS_DIR)/*.scss)
CSS_BUILD := $(BUILD_DIR)/style.css

ASSET_FILES := $(shell find $(ASSET_DIR))
ASSET_BUILD := $(subst $(ASSET_DIR),$(BUILD_DIR),$(ASSET_FILES))

# Testing for necessary programs
COMPASS := $(shell command -v compass 2> /dev/null)
MUSTACHE := $(shell command -v mustache 2> /dev/null)
FSWATCH := $(shell command -v fswatch 2> /dev/null)

ifndef COMPASS
$(error Compass is not available. Make sure it is installed)
endif

ifndef MUSTACHE
$(error Mustache is not available. Make sure it is installed)
endif

# Targets
site: checkLiveJS $(BUILD_DIR) $(HTML_BUILD) $(CSS_BUILD) $(JS_BUILD) $(ASSET_BUILD)

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

# Hacky code to indent HTML with sed
$(HTML_BUILD): $(HEAD) $(HTML_FILES)
	printf "<!DOCTYPE html>\n<html>\n" > $(HTML_BUILD)
	sed 's/^./$(HTML_INDENT)&/' $(HEAD) >> $(HTML_BUILD)
	printf "$(HTML_INDENT)<body>\n" >> $(HTML_BUILD)
	cat $(HTML_FILES) | sed 's/^./$(HTML_INDENT)$(HTML_INDENT)&/' >> $(HTML_BUILD)
	printf "$(HTML_INDENT)</body>\n" >> $(HTML_BUILD)
	printf "</html>\n" >> $(HTML_BUILD)

%.html: %.yaml %.mustache
	mustache $^ > $@

$(CSS_BUILD): $(SASS_FILES)
	compass compile

# Depends on jQuery
$(JS_BUILD): $(JS_FILES)
	printf '$$(document).ready(function(){' > $(JS_BUILD)
	cat $(JS_FILES) >> $(JS_BUILD)
	printf "});" >> $(JS_BUILD)

$(BUILD_DIR)/%: $(ASSET_DIR)/%
	cp -r $< $@

.PHONY: checkLiveJS clean prod watch

checkLiveJS:
ifndef WATCHING
ifneq ("$(wildcard $(LIVEJS))","")
	rm -f $(LIVEJS) $(JS_BUILD)
endif
endif

clean:
	rm -rf $(BUILD_DIR)
	find $(TEMPLATE_DIR) -type f -name '*.html' -exec rm {} +

prod: site
ifndef DIR
	$(error "Please specify a directory to copy the built files to. Usage: make prod DIR=[directory]")
endif
	rsync -Cav --del --exclude README.md --exclude LICENSE $(BUILD_DIR)/ $(DIR)

watch:
ifndef FSWATCH
	$(error "fswatch is not available. Make sure it is installed to use make watch")
endif
	printf "document.body.appendChild(document.createElement('script')).src='http://livejs.com/live.js';" > $(LIVEJS)
	make WATCHING=true
# -e regex excludes Vim specific files (modified from https://github.com/afcowie/buildtools/blob/master/inotifymake.sh)
# and html files generated from templates
	fswatch -xrE -e '.swp|.swx|4913|~$$|templates/.+\.html' --event Removed --event Created --event Updated --batch-marker $(WATCH_DIRS) | grep --line-buffered NoOp | xargs -n1 -I{} make WATCHING=true
