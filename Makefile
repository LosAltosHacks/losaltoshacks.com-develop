# Directory definitions
TEMPLATE_DIR := templates
SASS_DIR := sass
JS_DIR := js
ASSET_DIR := assets
WATCH_DIRS := $(TEMPLATE_DIR) $(SASS_DIR) $(JS_DIR) $(ASSET_DIR)
BUILD_DIR := build

# File list and build file definitions
HTML_FILES := $(wildcard $(TEMPLATE_DIR)/[!_]*)
HTML_BUILD := $(subst $(TEMPLATE_DIR),$(BUILD_DIR),$(HTML_FILES:.mustache=.html))

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

# Absolute paths let us cd to the templates directory so that Mustache can find partials.
$(TEMPLATE_DIR)/%.html: $(TEMPLATE_DIR)/%.yaml $(TEMPLATE_DIR)/%.mustache
	cd $(TEMPLATE_DIR) && mustache $(abspath $^) > $(abspath $@)

$(TEMPLATE_DIR)/%.html: $(TEMPLATE_DIR)/%.mustache
	cd $(TEMPLATE_DIR) && echo | mustache - $(abspath $^) > $(abspath $@)

$(BUILD_DIR)/%.html: $(TEMPLATE_DIR)/%.html
# Mustache indents blank lines in partials
	ex +'%s/\s\+$$' -scwq $^
	cp $^ $@

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

prod: site
ifndef DIR
	$(error "Please specify a directory to copy the built files to. Usage: make prod DIR=[directory]")
endif
	rsync -Cavh --del --exclude README.md --exclude LICENSE --exclude CNAME $(BUILD_DIR)/ $(DIR)

watch:
ifndef FSWATCH
	$(error "fswatch is not available. Make sure it is installed to use make watch")
endif
	printf "document.body.appendChild(document.createElement('script')).src='http://livejs.com/live.js';" > $(LIVEJS)
	make WATCHING=true
# -e regex excludes Vim specific files (modified from https://github.com/afcowie/buildtools/blob/master/inotifymake.sh)
	fswatch -xrE -e '.swp|.swx|4913|~$$' --event Removed --event Created --event Updated --batch-marker $(WATCH_DIRS) | grep --line-buffered NoOp | xargs -n1 -I{} make WATCHING=true
