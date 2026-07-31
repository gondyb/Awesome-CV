CC = xelatex
EXAMPLES_DIR = examples
RESUME_SRCS = $(shell find $(EXAMPLES_DIR)/resume -name '*.tex')

.PHONY: all resume coverletter clean-aux clean

all: resume coverletter

# xelatex has to run from inside examples/: awesome-cv.cls and fonts are symlinks
# there, and resume.tex uses relative \input paths, so running it from the repo
# root fails to resolve resume/experience.tex. Twice, so the PDF outlines settle.
# xelatex exits nonzero because it tries, and fails, to build a FontAwesome TFM
# before falling back to the bundled fonts/FontAwesome.ttf. The icons render fine,
# so the exit status is ignored and the build is verified by the PDF instead.
resume: $(EXAMPLES_DIR)/resume.tex $(RESUME_SRCS)
	@rm -f $(EXAMPLES_DIR)/resume.pdf
	-@cd $(EXAMPLES_DIR) && $(CC) -interaction=nonstopmode resume.tex >/dev/null
	-@cd $(EXAMPLES_DIR) && $(CC) -interaction=nonstopmode resume.tex >/dev/null
	@test -s $(EXAMPLES_DIR)/resume.pdf || { echo "resume.pdf was not produced"; exit 1; }
	@$(MAKE) --no-print-directory clean-aux
	@echo "built $(EXAMPLES_DIR)/resume.pdf"

coverletter: $(EXAMPLES_DIR)/coverletter.tex
	@rm -f $(EXAMPLES_DIR)/coverletter.pdf
	-@cd $(EXAMPLES_DIR) && $(CC) -interaction=nonstopmode coverletter.tex >/dev/null
	@test -s $(EXAMPLES_DIR)/coverletter.pdf || { echo "coverletter.pdf was not produced"; exit 1; }
	@$(MAKE) --no-print-directory clean-aux
	@echo "built $(EXAMPLES_DIR)/coverletter.pdf"

clean-aux:
	@rm -f $(EXAMPLES_DIR)/*.aux $(EXAMPLES_DIR)/*.log $(EXAMPLES_DIR)/*.out
	@rm -f $(EXAMPLES_DIR)/missfont.log missfont.log mfput.log

clean: clean-aux
	rm -f $(EXAMPLES_DIR)/*.pdf
