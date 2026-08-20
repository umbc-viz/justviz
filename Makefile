# h/t to @jimhester and @yihui for this parse block:
# https://github.com/yihui/knitr/blob/dc5ead7bcfc0ebd2789fe99c527c7d91afb3de4a/Makefile#L1-L4
# Note the portability change as suggested in the manual:
# https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Writing-portable-packages
PKGNAME := $(shell sed -n "s/Package: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGSRC  := $(shell basename `pwd`)

R_CMD = R -q -e
SRC = $(R_CMD) "source('$<')"
RUN_BASH = bash $<

.PHONY: all check document vignettes install clean datasets rasters readme
datasets := $(patsubst data-raw/%.R,data/%.rda,$(wildcard data-raw/*.R))
rasters := $(wildcard inst/raster/*.tif)

all: $(datasets) $(rasters) document check readme


############################# UTILS
check: DESCRIPTION
	$(R_CMD) "devtools::check(cran = FALSE, error_on = 'error')"

document: datasets
	$(R_CMD) "devtools::document()"

vignettes: vignettes/*.qmd
	$(R_CMD) "devtools::build_vignettes()"

install:
	$(R_CMD) "devtools::install()"

site: README.md document
	$(R_CMD) "devtools::build_site()"

readme: README.md

README.md: README.qmd
	$(R_CMD) "devtools::build_readme()"

clean:
	@rm -rf $(PKGNAME)_$(PKGVERS).tar.gz $(PKGNAME).Rcheck docs

############################# DATASETS

data/%.rda: data-raw/%.R
	$(SRC)

inst/raster/%.tif: data-raw/landcover.R
	$(SRC)

data-raw/files/usa_ipums_wages.dat.gz: data-raw/prep/get_ipums_wages.R
	$(SRC)

data/wages.rda: data-raw/files/usa_ipums_wages.dat.gz

data/spending.rda: $(wildcard data-raw/files/cx/*.xlsx)
