## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(fscontext, quietly = TRUE)
library(dplyr, quietly = TRUE)

vignette_folder <- file.path(tempdir(), "vignette")
camera <- file.path(vignette_folder, "camera")
photos <- file.path(vignette_folder, "photos")

unlink(c(vignette_folder, camera, photos), recursive = TRUE)

dir.create(vignette_folder)
dir.create(camera)
dir.create(photos)

for (i in 1:9) {
  writeLines(as.character(i),file.path(camera, paste0("P", i, ".txt")))
}


## ----showcamera---------------------------------------------------------------
dir(camera)

## ----snapshotbefore-----------------------------------------------------------
before <- snapshot_storage(path = camera, 
                           root = vignette_folder, 
                           person_id = "photographer")

## ----summarybefore------------------------------------------------------------
summary_before <- readRDS(before) |> 
  dplyr::select(person_id, rel_path, stem, size)

print(summary_before)

## ----organisephotos-----------------------------------------------------------
dir.create(file.path(photos, "house"), recursive = TRUE)
dir.create(file.path(photos, "garden"))
dir.create(file.path(photos, "delete"))

file.rename(
  file.path(camera, c("P1.txt","P2.txt","P5.txt")),
  file.path(photos, "house",
            c("P1.txt","P2.txt","P5.txt"))
)

file.rename(
  file.path(camera,
            c("P3.txt","P4.txt","P6.txt","P7.txt")),
  file.path(photos, "garden",
            c("P3.txt","P4.txt","P6.txt","P7.txt"))
)

file.rename(
  file.path(camera,
            c("P8.txt","P9.txt")),
  file.path(photos, "delete",
            c("P8.txt","P9.txt"))
)

## ----after--------------------------------------------------------------------
after <- snapshot_storage(path = photos, 
                          root = vignette_folder, 
                          person_id = "archivist")

## ----summaryafter-------------------------------------------------------------
summary_after <- readRDS(after) |> 
  dplyr::select(person_id, rel_path, stem, size)

print(summary_after)

## ----joinsummaries------------------------------------------------------------

summary_path_change <- summary_before |>
  rename(
    rel_path_before = rel_path,
    person_before = person_id
  ) |>
  left_join(
    summary_after |>
      rename(
        rel_path_after = rel_path,
        person_after = person_id
      ),
    by = c("stem", "size")
  ) |>
  select(
    stem, size,
    person_before, rel_path_before,
    rel_path_after, person_after
  ) |>
  filter(grepl("txt$", rel_path_before))


print(summary_path_change)

## -----------------------------------------------------------------------------
summary_path_change |>
  filter(stem == "P1") |>
  select(
    person_before,
    rel_path_before,
    rel_path_after,
    person_after
  ) |>
  tidyr::unite(
    col = "transition",
    rel_path_before,
    rel_path_after,
    sep = " → "
  )

