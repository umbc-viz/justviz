RUN_R = Rscript $<
RUN_BASH = bash $<

datasets := $(patsubst data-raw/%.R,data/%.rda,$(wildcard data-raw/*.R))

.PHONY: all
all: $(datasets)


data/%.rda: data-raw/%.R
	$(RUN_R)

data-raw/files/ejscreen_md.csv: data-raw/prep_ejscreen.sh
	$(RUN_BASH)

data/ejscreen.rda: data-raw/files/ejscreen_md.csv

data/wages.rda: data-raw/files/income_tbls.rds

data/wages_by_puma.rda: data-raw/files/income_by_puma.rds

data/spending.rda: $(wildcard data-raw/files/cx/*.xlsx)
