# Substantive checks for tab_1 — template study benchmarks
#
# Expected lm_robust(Y ~ X) estimates on data/data.csv (n = 8).

tab_1_benchmark <- function() {
  data.frame(
    term = c("(Intercept)", "X"),
    estimate = c(0.25, 0.50),
    std.error = c(0.2500000, 0.3535534),
    statistic = c(1.000000, 1.414214),
    p.value = c(0.3559177, 0.2070312),
    conf.low = c(-0.361728, -0.365114),
    conf.high = c(0.861728, 1.365114),
    df = c(6, 6),
    stringsAsFactors = FALSE
  )
}

#' @param object An `lm_robust` fit from `make_tab_1()`.
#' @param tolerance Absolute tolerance for numeric comparisons.
substantive_check_tab_1 <- function(object, tolerance = 1e-5) {
  stopifnot(inherits(object, "lm_robust"))
  expected <- tab_1_benchmark()
  got <- as.data.frame(summary(object)$coefficients)
  # estimatr summary uses Estimate, Std. Error, t value, Pr(>|t|), CI Lower, CI Upper, DF
  names(got) <- c("estimate", "std.error", "statistic", "p.value", "conf.low", "conf.high", "df")
  got$term <- rownames(summary(object)$coefficients)
  rownames(got) <- NULL
  got <- got[match(expected$term, got$term), , drop = FALSE]

  for (col in c("estimate", "std.error", "statistic", "p.value", "conf.low", "conf.high", "df")) {
    testthat::expect_equal(
      got[[col]],
      expected[[col]],
      tolerance = tolerance,
      info = paste("column", col)
    )
  }
  invisible(TRUE)
}
