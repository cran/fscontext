## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, echo=FALSE, message=FALSE, warning=FALSE--------------------------
library(fscontext)
library(knitr)
library(dplyr)

## ----eval=FALSE---------------------------------------------------------------
# snapshot <- scan_storage(root = "D:/projects")

## ----snapshot02---------------------------------------------------------------
data("fscontextdemo_snapshot_02")
fscontextdemo_snapshot_02 |>
  dplyr::select(storage_id, rel_path, filename) |>
  head()

## -----------------------------------------------------------------------------
snapshots <- add_snapshot_context(fscontextdemo_snapshot_02)

## -----------------------------------------------------------------------------
snapshots <- dplyr::bind_cols(
  snapshots,
  derive_structural_groups(
    snapshots$rel_path
  )
)

snapshots |>
  dplyr::select(
    rel_path,
    structural_group,
    component
  ) |>
  head()

## ----snapshotrecordsetdf------------------------------------------------------
tmp <- tempfile(fileext = ".rds")
saveRDS(fscontextdemo_snapshot_02, tmp)

record_set <- snapshot_to_recordset_df(
  creator = utils::person("Jane", "Doe"),
  snapshot_files = tmp,
  roots = "D:/_packages/fscontextdemo",
  record_set_identifier = "fscontextdemo"
)

## ----subsettingrecordset------------------------------------------------------
set.seed(12)
record_set |>
  dplyr::select(record_set_identifier, filename, quick_sig, size) |>
  sample_n(10)

## ----observeuniverse, eval=FALSE----------------------------------------------
# observe_universe(
#   snapshot_dir = snapshot_directory,
#   max_aggregation_depth = 2
# )

