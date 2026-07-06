## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, echo=FALSE, message=FALSE-----------------------------------------
library(fscontext)
library(dplyr)

## ----show-folder--------------------------------------------------------------
root <- system.file(
  "testdata/minimal_R_folder",
  package = "fscontext"
)

fs::dir_tree(root)

## ----observedemo--------------------------------------------------------------
snapshot <- scan_storage(
  system.file(
    "testdata/minimal_R_folder",
    package = "fscontext"
  )
)

groups <- derive_structural_groups(
  snapshot$rel_path,
  profile = "folder-depth-1"
)

## ----filtering----------------------------------------------------------------
groups %>%
  filter(structural_group %in% c("R", "man"))

## ----zip----------------------------------------------------------------------
zip_snapshot <- scan_storage(
  system.file(
    "testdata/minimal_R_folder.zip",
    package = "fscontext"
  )
)

## ----derivestructuralgroups---------------------------------------------------
zip_groups <- derive_structural_groups(
  zip_snapshot$rel_path,
  profile = "folder-depth-1"
)

## ----filterstructuralgroups---------------------------------------------------
zip_groups %>%
  filter(structural_group %in% c("R", "man"))

## ----observewacz--------------------------------------------------------------
wacz <- scan_storage(
  system.file(
    "testdata/fscontext_020.wacz",
    package = "fscontext"
  )
)

derive_structural_groups(
  wacz$rel_path,
  profile = "wacz"
)

