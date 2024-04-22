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

.PHONY: all check document vignettes install clean datasets rasters readme
datasets := $(patsubst data-raw/%.R,data/%.rda,$(wildcard data-raw/*.R))
rasters := $(wildcard inst/raster/*.tif)

all: $(datasets) $(rasters) document check readme


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

inst/raster/%.tif: data-raw/%.R
	$(SRC)

data-raw/files/ejscreen_md_%.csv: data-raw/prep_ejscreen.sh
	$(RUN_BASH)

data/ejscreen.rda: data-raw/files/ejscreen_md_state.csv

data/ej_natl.rda: data-raw/files/ejscreen_md_natl.csv

data/ej_trend.rda: data-raw/files/ej_trend.duckdb

data-raw/files/ej_trend.duckdb: data-raw/prep_ej_trend.sh
	$(RUN_BASH)

data/wages.rda: data-raw/files/income_tbls.rds

data/wages_by_puma.rda: data-raw/files/income_by_puma.rds

data/spending.rda: $(wildcard data-raw/files/cx/*.xlsx)
