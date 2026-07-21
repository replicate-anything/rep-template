# rep-template

Minimal unpublished folder-backed study for [replicateEverything](https://github.com/replicate-anything/replicateEverything).

- **Handle:** `rep-template` (no article DOI)
- **Authors:** ReplicateEverything Team
- **One table:** OLS of `Y` on `X` with `estimatr::lm_robust`, formatted for Shiny Display

## Layout

```
replication.yml   # metadata + steps DAG
data/data.csv     # toy input
code/tab_1.R      # make_tab_1() + format_tab_1()
outputs/          # precomputed HTML for Display
tests/            # testthat + substantive benchmarks
```

## Validate

From a monorepo checkout (sibling of `registry/` and `replicateEverything/`):

```r
options(
  replicateEverything.registry_root = "../registry",
  replicateEverything.use_sibling_packages = TRUE
)
replicateEverything::check_replication(".")
replicateEverything::build_study_outputs(".")
testthat::test_dir("tests/testthat")
```

## Credits

Template study for the replicate-anything project. Not linked to a published paper.
