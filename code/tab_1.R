# Table 1 — Minimal template study
# Study repo: https://github.com/replicate-anything/rep-template
# Execute via: run_replication("rep-template", "tab_1")  (yaml is the recipe)

library(estimatr)

make_tab_1 <- function(data) {
  estimatr::lm_robust(Y ~ X, data = data)
}

format_tab_1 <- function(object) {
  coefs <- as.data.frame(summary(object)$coefficients)
  knitr::kable(coefs, format = "html", digits = 3)
}
