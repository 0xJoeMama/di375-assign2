LATEX=lualatex
LATEX_FLAGS=--shell-escape --halt-on-error
DOCS=assign2_part_A.pdf assign2_part_B.pdf
TMP=build
ZIP=LDL_assign2_$(USER)_part_B.zip
ZIP_CONTENTS=$(DOCS)
CODE=code

all: $(DOCS)

%.pdf: %.tex
	$(LATEX) $(LATEX_FLAGS) $^ 

$(TMP):
	mkdir -p $@

zip: $(ZIP_CONTENTS)
	zip -j $(ZIP) $^

clean:
	rm -rf $(DOCS) *.aux *.log _minted* $(TMP) *.zip

LDL_assign2_$(USER)_partB.zip: assign2_part_B.pdf
	zip -r $@ assign2_part_B.pdf $(CODE)/part-2/* images
	
submission_zip: assign2_part_A.pdf LDL_assign2_$(USER)_partB.zip
	zip -r LDL_assign2_$(USER).zip $^
	
