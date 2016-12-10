TEMPLATE_DIR := templates
SASS_DIR := sass
JS_DIR := js
ASSET_DIR := assets
WATCH_DIRS := "$(TEMPLATE_DIR)", "$(SASS_DIR)", "$(JS_DIR)", "$(ASSET_DIR)"
ARCHIVE_DIR := archive
BUILD_DIR := build
PROGRAM_DEPS := ruby gem bundle


MUSTACHE_FILES := $(wildcard $(TEMPLATE_DIR)/[!_]*.mustache)
MUSTACHE_PARTIALS := $(wildcard $(TEMPLATE_DIR)/_*.mustache)
YAML_FILES := $(wildcard $(TEMPLATE_DIR)/*.yaml)

# Check for missing Mustache/YAML files
MUSTACHE_BASENAMES := $(basename $(MUSTACHE_FILES))
YAML_BASENAMES := $(basename $(YAML_FILES))
TEMPLATE_PAIRS := $(filter $(YAML_BASENAMES), $(MUSTACHE_BASENAMES))
SINGLE_FILES := $(strip $(addsuffix .yaml,$(filter-out $(TEMPLATE_PAIRS),$(YAML_BASENAMES))) \
                        $(addsuffix .mustache,$(filter-out $(TEMPLATE_PAIRS),$(MUSTACHE_BASENAMES))))

$(if $(SINGLE_FILES),$(error Some Mustache/YAML files are missing. "$(SINGLE_FILES)" cannot be built),)
$(if $(wildcard $(TEMPLATE_DIR)/index.mustache),, \
     $(error $(TEMPLATE_DIR)/index.mustache and $(TEMPLATE_DIR)/index.yaml are missing))

# Place HTML files in their own directory for clean URLs (except for the root
# index.html). For example, "about.mustache" will be built as
# "/about/index.html" instead of "/about.html".
HTML_BUILD := $(foreach slug,$(filter-out index,$(notdir $(MUSTACHE_BASENAMES))),\
                             $(BUILD_DIR)/$(slug)/index.html)
HTML_BUILD += $(BUILD_DIR)/index.html


JS_FILES := $(wildcard $(JS_DIR)/*.js)
JS_BUILD := $(BUILD_DIR)/script.js

SASS_FILE := $(SASS_DIR)/style.scss
CSS_BUILD := $(BUILD_DIR)/style.css

ASSET_LINKS := $(patsubst $(ASSET_DIR)/%,$(BUILD_DIR)/%,$(wildcard $(ASSET_DIR)/*))
2016_LINK := $(BUILD_DIR)/2016


site: deps $(BUILD_DIR) 2017 $(2016_LINK)
2017: $(HTML_BUILD) $(CSS_BUILD) $(JS_BUILD) $(ASSET_LINKS)

$(BUILD_DIR):
	mkdir $@

# We cd to the templates directory so that Mustache can find partials.
# MUSTACHE_PARTIALS are added as a prerequisite so that non-partials are rebuilt
# when partials are modified.
%.html: %.yaml %.mustache $(MUSTACHE_PARTIALS)
	cd $(@D) && mustache $(*F).yaml $(*F).mustache > $(@F)
# Remove lines with just whitespace, as Mustache indents blank lines in partials
	perl -pi -e 's/^[ \t]+$$//' $@

$(BUILD_DIR)/%.html: $(TEMPLATE_DIR)/%.html
	mv $^ $@

$(BUILD_DIR)/%/index.html: $(TEMPLATE_DIR)/%.html
	mkdir -p $(BUILD_DIR)/$*
	mv $^ $@

$(CSS_BUILD): $(SASS_FILE)
	sass -t compressed --sourcemap=none $< $@
# The CSS must be slurped to use autoprefixer-rails. It should not be slow if
# the file is small enough.
	ruby -e 'require "autoprefixer-rails"; \
	         css = File.read("$@"); \
	         File.open("$@", "w") { |io| io << AutoprefixerRails.process(css) }'

$(JS_BUILD): $(JS_FILES)
	cat $(JS_FILES) > $(JS_BUILD)

$(ASSET_LINKS):
	ln -s ../$(ASSET_DIR)/$(@F) $(BUILD_DIR)

$(2016_LINK):
	ln -s ../$(ARCHIVE_DIR)/2016 $(BUILD_DIR)


clean:
	rm -rf $(BUILD_DIR)

prod: site
ifndef DIR
	$(error Please specify a directory to copy the built files to. Usage: make prod DIR=[directory])
endif
	find -L $(BUILD_DIR) -maxdepth 1 -type l -exec rm {} +
	rsync -CavhL --del --exclude README.md --exclude LICENSE --exclude CNAME $(BUILD_DIR)/ $(DIR)

watch: site
	@echo "Listening for changes..."
	@ruby -e 'require "listen"; \
	          listener = Listen.to($(WATCH_DIRS), latency: 0.5) { \
	            puts "\n" + Time.now.strftime("%-l:%M:%S%P"); \
	            system("make --no-print-directory") \
	          }; listener.start; at_exit { listener.stop }; sleep'

help:
	@echo 'The Los Altos Hacks website'
	@echo
	@echo 'Usage: make [target...]'
	@echo
	@echo 'Available targets:'
	@echo '    site                         Build the whole site (default target)'
	@echo '    clean                        Delete build files'
	@echo '    watch                        Rebuild the site when files change'
	@echo '    prod DIR=[directory]         Build site and copy files to DIR'
	@echo '    help                         Show this help dialog'

deps:
	$(foreach dep,$(PROGRAM_DEPS), \
	    $(if $(shell command -v $(dep) 2> /dev/null),, \
	    $(error $(dep) is not available. Make sure it is installed)))

	$(if $(findstring missing,$(shell bundle check)), \
	    $(info Some gems are missing. Running bundle install...) \
	    $(value $(shell bundle install)),)

.PHONY: site 2017 clean prod watch help deps

# Disable implicit rules to speed up processing and declutter debug output
.SUFFIXES:
%: %,v
%: RCS/%,v
%: RCS/%
%: s.%
%: SCCS/s.%
