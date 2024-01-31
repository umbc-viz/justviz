# h/t to @jimhester and @yihui for this parse block:
# https://github.com/yihui/knitr/blob/dc5ead7bcfc0ebd2789fe99c527c7d91afb3de4a/Makefile#L1-L4
# Note the portability change as suggested in the manual:
# https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Writing-portable-packages
PKGNAME := $(shell sed -n "s/Package: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGSRC  := $(shell basename `pwd`)

R_CMD = R -q -e
SRC = $(R_CMD) "devtools::load_all(); source('$<')"
RUN_BASH = bash $<

.PHONY: all check document vignettes install clean datasets readme

all: datasets document check readme

datasets := $(patsubst data-raw/%.R,data/%.rda,$(wildcard data-raw/*.R))

############################# UTILS
check: DESCRIPTION
	$(R_CMD) "devtools::check(cran = FALSE)"

document:
	$(R_CMD) "devtools::document()"

vignettes: vignettes/*.Rmd
	$(R_CMD) "devtools::build_vignettes()"

install:
	$(R_CMD) "devtools::install()"

site: README.md document
	$(R_CMD) "devtools::build_site()"

readme: README.md

README.md: README.Rmd
	$(R_CMD) "devtools::build_readme()"

clean:
	@rm -rf $(PKGNAME)_$(PKGVERS).tar.gz $(PKGNAME).Rcheck docs

############################# DATASETS

data/%.rda: data-raw/%.R
	$(SRC)

data-raw/files/ejscreen_md.csv: data-raw/prep_ejscreen.sh
	$(RUN_BASH)

data/ejscreen.rda: data-raw/files/ejscreen_md.csv

data/wages.rda: data-raw/files/income_tbls.rds

data/wages_by_puma.rda: data-raw/files/income_by_puma.rds

data/spending.rda: $(wildcard data-raw/files/cx/*.xlsx)
