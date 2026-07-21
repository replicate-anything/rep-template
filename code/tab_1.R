# Table 1 — Minimal template study
# Study repo: https://github.com/replicate-anything/rep-template
# Run from the study repo code/ folder: Rscript tab_1.R

library(estimatr)
library(modelsummary)
library(kableExtra)

make_tab_1 <- function(data) {
  estimatr::lm_robust(Y ~ X, data = data)
}

format_tab_1 <- function(object) {
  tab <- modelsummary::modelsummary(
    object,
    output = "kableExtra",
    stars = FALSE,
    statistic = "({std.error})",
    gof_map = c("nobs", "r.squared"),
    title = "Simple table showing from template repo"
  ) |>
    kableExtra::kable_styling(
      bootstrap_options = c("condensed", "hover"),
      full_width = FALSE,
      position = "left"
    )

  as.character(tab)
}

if (sys.nframe() == 0L) {
  data <- utils::read.csv("../data/data.csv", stringsAsFactors = FALSE)
  make_tab_1(data) |> format_tab_1()
}
