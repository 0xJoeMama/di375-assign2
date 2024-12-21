LATEX=lualatex
LATEX_FLAGS=--shell-escape --halt-on-error
DOCS=assign2_part_A.pdf assign2_part_B.pdf
TMP=build
ZIP=LDL_assign2_$(USER)_part_B.zip
ZIP_CONTENTS=$(DOCS)

all: $(DOCS)

%.pdf: %.tex
	$(LATEX) $(LATEX_FLAGS) $^ 

$(TMP):
	mkdir -p $@

zip: $(ZIP_CONTENTS)
	zip -j $(ZIP) $^

clean:
	rm -rf $(DOCS) *.aux *.log _minted* $(TMP) *.zip

