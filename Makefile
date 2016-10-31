# Directory definitions
TEMPLATE_DIR := templates
SASS_DIR := sass
JS_DIR := js
ASSET_DIR := assets
WATCH_DIRS := $(TEMPLATE_DIR) $(SASS_DIR) $(JS_DIR) $(ASSET_DIR)
ARCHIVE_DIR := archive
BUILD_DIR := build

# File list and build file definitions
HTML_FILES := $(wildcard $(TEMPLATE_DIR)/[!_]*.mustache)
HTML_PARTIALS := $(wildcard $(TEMPLATE_DIR)/_*.mustache)
HTML_BUILD := $(HTML_FILES:.mustache=.html)

# We want to place files such as "about.mustache" in their own directory, so
# that they're built as "/about/index.html" instead of "/about.html". So, we
# run a foreach to rename the files to their appropriate path. But the root
# "index.html" is an exception: it should not be placed in "/index/index.html".
# So we check for its presence and filter it out if necessary.
ifneq (,$(findstring index.html,$(HTML_BUILD)))
# Found index.html, filter it out and add it in at the end
HTML_BUILD := $(filter-out $(TEMPLATE_DIR)/index.html,$(HTML_BUILD))
HTML_BUILD := $(foreach FILE,$(HTML_BUILD),$(BUILD_DIR)/$(notdir $(basename $(FILE)))/index.html)
HTML_BUILD += $(BUILD_DIR)/index.html
else
# Didn't find index.html
HTML_BUILD := $(foreach FILE,$(HTML_BUILD),$(BUILD_DIR)/$(notdir $(basename $(FILE)))/index.html)
endif

JS_FILES := $(wildcard $(JS_DIR)/*.js)
JS_BUILD := $(BUILD_DIR)/script.js
LIVEJS := $(JS_DIR)/live.js
ifndef WATCHING
JS_FILES := $(filter-out $(LIVEJS),$(JS_FILES))
endif

SASS_FILES := $(wildcard $(SASS_DIR)/*.scss)
CSS_BUILD := $(BUILD_DIR)/style.css

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


site: 2017
2017: checkLiveJS $(BUILD_DIR) $(HTML_BUILD) $(CSS_BUILD) $(JS_BUILD) assets 2016

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

# Absolute paths let us cd to the templates directory so that Mustache can find partials.
# HTML_PARTIALS added as a hack to rebuild non-partials when partials are updated.
# Partials are filtered or ignored from the actual prerequisites.
$(TEMPLATE_DIR)/%.html: $(TEMPLATE_DIR)/%.yaml $(TEMPLATE_DIR)/%.mustache $(HTML_PARTIALS)
	cd $(TEMPLATE_DIR) && mustache $(abspath $(filter-out $(TEMPLATE_DIR)/_%,$^)) > $(abspath $@)

$(TEMPLATE_DIR)/%.html: $(TEMPLATE_DIR)/%.mustache $(HTML_PARTIALS)
# We echo nothing to fill in for the lack of a YAML file
	cd $(TEMPLATE_DIR) && echo | mustache - $(abspath $<) > $(abspath $@)

$(BUILD_DIR)/index.html: $(TEMPLATE_DIR)/index.html
# Remove lines with just whitespace, as Mustache indents blank lines in partials
	perl -pi -e 's/^[ \t]+$$//gm' $^
	mv $^ $@

$(BUILD_DIR)/%/index.html: $(TEMPLATE_DIR)/%.html
	perl -pi -e 's/^[ \t]+$$//gm' $^
	mkdir -p $(BUILD_DIR)/$(notdir $(basename $^))
	mv $^ $@

$(CSS_BUILD): $(SASS_FILES)
	compass compile

# Depends on jQuery
$(JS_BUILD): $(JS_FILES)
	printf '$$(document).ready(function(){' > $(JS_BUILD)
	cat $(JS_FILES) >> $(JS_BUILD)
	printf "});" >> $(JS_BUILD)


.PHONY: site 2017 assets 2016 checkLiveJS clean prod watch

# These rsync targets are phony because rsync only copies files that have changed anyways

# rsync doesn't delete asset files removed from the source tree here because a)
# they will eventually be deleted by make clean/prod, and b) it means that
# macros aren't necessary to build a command to exclude from deleting all the
# files generated by other targets in build/ (e.g. index.html, a file not in
# assets/ which would be removed by rsync --del)
assets:
	rsync -a $(ASSET_DIR)/ $(BUILD_DIR)

# rsync does delete old files here because there are no files to exclude and
# old files will get cleaned up by make clean/prod
2016:
	rsync -a --del $(ARCHIVE_DIR)/2016 $(BUILD_DIR)/

checkLiveJS:
ifndef WATCHING
ifneq ("$(wildcard $(LIVEJS))","")
	rm -f $(LIVEJS) $(JS_BUILD)
endif
endif

clean:
	rm -rf $(BUILD_DIR) $(LIVEJS)

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
