# Table 1 — Minimal template study
# Study repo: https://github.com/replicate-anything/rep-template
# Execute via: run_replication("rep-template", "tab_1")  (yaml is the recipe)

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
