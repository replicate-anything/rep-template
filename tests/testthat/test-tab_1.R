HANDLE <- "rep-template"
WHAT <- "tab_1"
FOLDER <- "rep-template"
STUDY_REPO <- "replicate-anything/rep-template"

study_test_context <- function() {
  study_root <- normalizePath(
    testthat::test_path("..", ".."),
    winslash = "/",
    mustWork = FALSE
  )
  registry_root <- normalizePath(
    file.path(study_root, "..", "registry"),
    winslash = "/",
    mustWork = FALSE
  )
  monorepo_root <- normalizePath(
    file.path(study_root, ".."),
    winslash = "/",
    mustWork = FALSE
  )

  local_index <- data.frame(
    folder = FOLDER,
    handle = HANDLE,
    doi = "",
    title = "Minimal folder-backed template study",
    journal = "",
    year = 2026L,
    authors = "ReplicateEverything Team",
    repo = STUDY_REPO,
    stringsAsFactors = FALSE
  )

  list(
    study_root = study_root,
    registry_root = registry_root,
    monorepo_root = monorepo_root,
    local_index = local_index
  )
}

test_that("run_replication executes tab_1 and matches benchmarks", {
  testthat::skip_if_not_installed("replicateEverything")
  testthat::skip_if_not_installed("estimatr")
  testthat::skip_if_not_installed("knitr")

  ctx <- study_test_context()
  testthat::skip_if_not(
    file.exists(file.path(ctx$study_root, "data", "data.csv")),
    "study data missing"
  )

  withr::with_options(
    list(
      replicateEverything.registry_root = ctx$registry_root,
      replicateEverything.index = ctx$local_index,
      replicateEverything.use_sibling_packages = TRUE,
      replicateEverything.study_folders_root = ctx$monorepo_root
    ),
    {
      fit <- replicateEverything::run_replication(HANDLE, WHAT)
      testthat::expect_s3_class(fit, "lm_robust")

      source(file.path(ctx$study_root, "tests/substantive/tab_1.R"), local = TRUE)
      substantive_check_tab_1(fit)

      html <- replicateEverything::run_replication(HANDLE, WHAT, format = TRUE)
      testthat::expect_true(is.character(html))
      testthat::expect_true(grepl("<table", html[[1]], ignore.case = TRUE))
    }
  )
})

test_that("tab_1 artifact exists for Shiny Display", {
  ctx <- study_test_context()
  art <- file.path(ctx$study_root, "outputs", "tab_1.html")
  testthat::expect_true(file.exists(art), label = art)
})
