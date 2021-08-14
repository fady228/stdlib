#/
# @license Apache-2.0
#
# Copyright (c) 2017 The Stdlib Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#/

# VARIABLES #

# Define the path to the remark configuration file:
REMARK_TOC_CONF ?= $(CONFIG_DIR)/remark/.remarkrc.js

# Define the path to the remark ignore file:
# REMARK_TOC_IGNORE ?= $(CONFIG_DIR)/remark/.remarkignore FIXME
REMARK_TOC_IGNORE ?= $(ROOT_DIR)/.remarkignore

# Define the path to a plugin which processes Markdown table of contents comments:
REMARK_TOC_PLUGIN ?= $(TOOLS_PKGS_DIR)/remark/plugins/remark-namespace-toc
REMARK_TOC_PLUGIN_SETTINGS ?=
REMARK_TOC_PLUGIN_FLAGS ?= --use $(REMARK_TOC_PLUGIN)=$(REMARK_TOC_PLUGIN_SETTINGS)

# Define command-line options when invoking the remark executable:
REMARK_TOC_FLAGS ?= \
	--ext $(MARKDOWN_FILENAME_EXT) \
	--rc-path $(REMARK_TOC_CONF) \
	--ignore-path $(REMARK_TOC_IGNORE)

# Define the remark output option:
REMARK_TOC_OUTPUT_FLAG ?= --output


# RULES #

#/
# Updates the table of contents of namespace Markdown files.
#
# ## Notes
#
# -   In order to update table of contents, a namespace Markdown file must contain namespace table of contents comments.
#
# @param {string} [MARKDOWN_FILTER] - file path pattern (e.g., `.*/math/base/special/.*`)
# @param {string} [MARKDOWN_PATTERN] - filename pattern (e.g., `*.md`)
#
# @example
# make markdown-namespace-tocs
#
# @example
# make markdown-namespace-tocs MARKDOWN_PATTERN='README.md' MARKDOWN_FILTER='.*/math/base/special/.*'
#/
markdown-namespace-tocs: $(NODE_MODULES) assert-clean-working-directory
	$(QUIET) NODE_PATH="$(NODE_PATH)" $(REMARK) $(MARKDOWN_FILES) \
		$(REMARK_TOC_FLAGS) \
		$(REMARK_TOC_PLUGIN_FLAGS) \
		$(REMARK_TOC_OUTPUT_FLAG)

.PHONY: markdown-namespace-tocs
