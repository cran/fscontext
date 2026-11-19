## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(fscontext)
library(dplyr)
library(fscontext)
library(tibble)

## -----------------------------------------------------------------------------
# # install.packages("pak")
# pak::pak("dataobservatory-eu/betwixt")

## -----------------------------------------------------------------------------
# review_input <- tibble::tribble(
#   ~page_id, ~title, ~page_url, ~thumbnail_url, ~value,
#   "635780", "sweater, women's",
#   "https://www.muis.ee/museaalview/635780",
#   "https://www.muis.ee/digitaalhoidla/api/meedia/pisipilt?id=ebc07930-f719-44f2-a108-6698bcecc20b",
#   "sweaters",
#   "633053", "gloves",
#   "https://www.muis.ee/museaalview/633053",
#   "https://www.muis.ee/digitaalhoidla/api/meedia/pisipilt?id=6440f24f-eaad-4cd4-84d7-1ae7a9d44d5a",
#   "gloves",
#   "635778", "shirt, women's",
#   "https://www.muis.ee/museaalview/635778",
#   "https://www.muis.ee/digitaalhoidla/api/meedia/pisipilt?id=826c402e-c130-4860-b11e-9538bd403ecf",
#   "shirts"
# )

## -----------------------------------------------------------------------------
# image_dir <- file.path(tempdir(), "muis-images")
# dir.create(image_dir, showWarnings = FALSE)
# 
# download_map <- tibble::tibble(
#   thumbnail_url = review_input$thumbnail_url,
#   filename = paste0(review_input$page_id, ".jpg"),
#   local_path = file.path(
#     image_dir,
#     paste0(review_input$page_id, ".jpg")
#   )
# )
# 
# for (i in seq_along(download_map$thumbnail_url)) {
#   download.file(
#     url = download_map$thumbnail_url[i],
#     destfile = download_map$local_path[i],
#     mode = "wb",
#     quiet = TRUE
#   )
# }
# 
# download_map

## -----------------------------------------------------------------------------
# images <- fscontext::scan_storage(
#   root = image_dir,
#   storage_id = "muis-review",
#   person_id = "reviewer",
#   compute_signature = TRUE
# )
# 
# images |>
#   select(
#     filename,
#     storage_path_id,
#     quick_sig
#   )

## -----------------------------------------------------------------------------
# image_evidence <- images |>
#   left_join(
#     download_map,
#     by = "filename"
#   ) |>
#   left_join(
#     review_input |>
#       select(
#         page_id,
#         title,
#         page_url,
#         thumbnail_url
#       ),
#     by = "thumbnail_url"
#   )

## -----------------------------------------------------------------------------
# resource_review <- betwixt::candidate_dataset(
#   evidence_url = image_evidence$thumbnail_url,
#   evidence_text = image_evidence$filename,
#   label = image_evidence$filename,
#   description = paste(
#     "Downloaded from MuIS record",
#     image_evidence$page_id
#   ),
#   subject = image_evidence$storage_path_id
# ) |>
#   betwixt::add_candidate_column(
#     value = image_evidence$page_url,
#     definition = rep(
#       "derived from source record",
#       nrow(image_evidence)
#     )
#   )
# 
# resource_review

## -----------------------------------------------------------------------------
# betwixt::betwixt_render(
#   resource_review,
#   cols = c(
#     col_1 = "Digital resource",
#     col_2 = "source record"
#   ),
#   title = "MuIS digital resource review",
#   description = "Review the identity and source of each observed image.",
#   project_id = "muis-example",
#   filename_stem = "muis-resource-review",
#   sequence = 0L,
#   path = tempdir()
# )
# 
# betwixt_review_1 <- readLines(
#   con = file.path(tempdir(), "muis-resource-review.html")
# )

## -----------------------------------------------------------------------------
# writeLines(
#   text = betwixt_review_1,
#   con = file.path(
#     here::here(),
#     "vignettes", "artefacts",
#     "muis-resource-review.html"
#   )
# )

## -----------------------------------------------------------------------------
# object_review <- betwixt::candidate_dataset(
#   evidence_url = review_input$thumbnail_url,
#   evidence_text = review_input$title,
#   label = review_input$title,
#   description = paste(
#     "Heritage object described by MuIS record",
#     review_input$page_id
#   ),
#   subject = review_input$page_url
# ) |>
#   betwixt::add_candidate_column(
#     value = review_input$value,
#     range = candidate_range(
#       "sweaters",
#       "gloves",
#       "shirts",
#       "Other…"
#     ),
#     definition = rep(
#       "object type",
#       nrow(review_input)
#     )
#   )

## -----------------------------------------------------------------------------
# betwixt::betwixt_render(
#   object_review,
#   cols = c(
#     col_1 = "Heritage object",
#     col_2 = "object type"
#   ),
#   title = "MuIS heritage object review",
#   description = "Review the candidate classification of each heritage object.",
#   project_id = "muis-example",
#   filename_stem = "muis-object-review",
#   sequence = 0L,
#   path = tempdir()
# )
# 
# betwixt_review_2 <- readLines(
#   con = file.path(tempdir(), "muis-object-review.html")
# )

## -----------------------------------------------------------------------------
# writeLines(
#   text = betwixt_review_2,
#   con = file.path(
#     here::here(),
#     "vignettes", "artefacts", "muis-object-review.html"
#   )
# )

