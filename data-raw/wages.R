# quick-ish survey analysis: median earnings by sex, race, education, work status
# MD only
path_in <- file.path("data-raw", "files", "usa_ipums_wages.xml")
ddi <- ipumsr::read_ipums_ddi(path_in)

pums <- ipumsr::read_ipums_micro(
    ddi,
    data_file = stringr::str_replace(path_in, "\\.xml", ".dat.gz")
) |>
    janitor::clean_names() |>
    dplyr::mutate(educd = ipumsr::lbl_na_if(educd, ~ .val %in% c(999, 1))) |>
    dplyr::mutate(age = ipumsr::lbl_na_if(age, ~ .val == 999)) |>
    dplyr::mutate(dplyr::across(c(labforce, wkswork2, uhrswork, educd), \(x) {
        ipumsr::lbl_na_if(x, ~ .val == 0)
    })) |>
    dplyr::mutate(dplyr::across(dplyr::where(ipumsr::is.labelled), \(x) {
        forcats::as_factor(ipumsr::lbl_clean(x))
    })) |>
    dplyr::mutate(
        edu = educd |>
            forcats::fct_collapse(
                high_school_diploma = c(
                    "Regular high school diploma",
                    "GED or alternative credential"
                ),
                some_college = c(
                    "Some college, but less than 1 year",
                    "1 or more years of college credit, no degree",
                    "Associate's degree, type not specified"
                ),
                bachelors = "Bachelor's degree",
                graduate_degree = c(
                    "Master's degree",
                    "Professional degree beyond a bachelor's degree",
                    "Doctoral degree"
                )
            ) |>
            forcats::fct_other(
                keep = c(
                    "high_school_diploma",
                    "some_college",
                    "bachelors",
                    "graduate_degree"
                ),
                other_level = "no_diploma"
            ) |>
            forcats::fct_relevel(
                "no_diploma",
                "high_school_diploma",
                "some_college",
                "bachelors"
            )
    ) |>
    dplyr::mutate(
        incearn = forcats::fct_recode(
            incearn,
            "0" = "No earnings",
            "-10000" = "-$10,000 (bottom code), see constituent variables for top code"
        )
    ) |>
    dplyr::mutate(dplyr::across(c(age, uhrswork, incearn), \(x) {
        readr::parse_number(as.character(x))
    })) |>
    dplyr::mutate(
        race2 = ifelse(
            hispan == "Not Hispanic",
            as.character(race),
            "Latino"
        ) |>
            forcats::as_factor() |>
            forcats::fct_recode(
                black = "Black/African American",
                native = "American Indian or Alaska Native"
            ) |>
            forcats::fct_collapse(
                api = c(
                    "Japanese",
                    "Chinese",
                    "Other Asian or Pacific Islander"
                )
            ) |>
            forcats::fct_relabel(tolower) |>
            forcats::fct_other(
                keep = c("white", "black", "api", "latino"),
                other_level = "other_race"
            ) |>
            forcats::fct_relevel("white", "black", "latino", "api")
    ) |>
    dplyr::mutate(sex = forcats::fct_relabel(sex, tolower)) |>
    dplyr::mutate(
        labforce = forcats::fct_recode(
            labforce,
            in_labor_force = "Yes, in the labor force",
            not_in_labor_force = "No, not in the labor force"
        )
    ) |>
    dplyr::mutate(
        full_time = forcats::as_factor(
            dplyr::case_when(
                is.na(uhrswork) |
                    is.na(wkswork2) |
                    is.na(labforce) ~ NA_character_,
                labforce == "in_labor_force" &
                    uhrswork >= 35 &
                    wkswork2 == "50-52 weeks" ~ "full_time",
                TRUE ~ "part_time"
            )
        )
    ) |>
    dplyr::mutate(puma = sprintf("09%05s", as.character(puma))) |>
    dplyr::filter(incearn > 0, labforce == "in_labor_force", age >= 25) |>
    dplyr::select(
        year,
        statefip,
        serial,
        strata,
        puma,
        perwt,
        hhwt,
        pernum,
        age,
        sex,
        gq,
        race_eth = race2,
        edu,
        full_time,
        labforce,
        wkswork2,
        uhrswork,
        earn = incearn
    )

summary(pums)


calc_wages <- function(srvys, ..., value_col = earn) {
    grp_vars <- rlang::quos(...)
    srvys <- purrr::map(srvys, dplyr::group_by, !!!grp_vars)
    srvys <- purrr::map(
        srvys,
        function(svy) {
            dplyr::summarise(
                svy,
                count = srvyr::survey_total(),
                sample_n = dplyr::n(),
                dplyr::across(
                    {{ value_col }},
                    list(\(x) {
                        srvyr::survey_quantile(x, c(0.2, 0.25, 0.5, 0.75, 0.8))
                    }),
                    .names = "{.col}"
                )
            )
        }
    )
    svy_df <- dplyr::bind_rows(srvys, .id = "status")
    dplyr::ungroup(svy_df)
}


full_design <- pums |>
    srvyr::as_survey_design(weights = perwt)
svy_list <- list(
    all_workers = full_design,
    part_time = full_design |> dplyr::filter(full_time == "part_time"),
    full_time = full_design |> dplyr::filter(full_time == "full_time")
)

out <- list()
# better way to do this with lists of args
# all work statuses for larger groups (by sex, by race)
out[["total"]] <- calc_wages(
    svy_list,
    sex = "total",
    race_eth = "total",
    edu = "total"
)
out[["by_sex"]] <- calc_wages(
    svy_list,
    sex,
    race_eth = "total",
    edu = "total"
)
out[["by_race"]] <- calc_wages(
    svy_list,
    sex = "total",
    race_eth,
    edu = "total"
)
out[["by_edu"]] <- calc_wages(
    svy_list,
    sex = "total",
    race_eth = "total",
    edu
)

# full-time only for smaller groups
out[["by_sex_x_race"]] <- calc_wages(
    svy_list["full_time"],
    sex,
    race_eth,
    edu = "total"
)
out[["by_sex_x_edu"]] <- calc_wages(
    svy_list["full_time"],
    sex,
    race_eth = "total",
    edu
)

wages <- dplyr::bind_rows(out, .id = "dimension") |>
    dplyr::select(-dplyr::matches("_se")) |>
    dplyr::mutate(dplyr::across(
        c(dimension, status, sex, race_eth, edu),
        forcats::as_factor
    )) |>
    dplyr::mutate(
        sex = forcats::fct_recode(sex, men = "male", women = "female")
    )

usethis::use_data(wages, overwrite = TRUE)
