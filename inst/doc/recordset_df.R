## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(fscontext)
tmp_dir <- file.path(tempdir(), "recordset_df")
if (dir.exists(tmp_dir)) unlink(tmp_dir, recursive = TRUE)
dir.create(tmp_dir)

writeLines(
  c("<html>", "<body>", "Description of the A object.", "</body>", "</html>"),
  file.path(tmp_dir, "a.html")
)
Sys.sleep(1)

writeBin(charToRaw("JPEG"), file.path(tmp_dir, "a.jpg"))
Sys.sleep(1)

writeLines(
  c("<html>", "<body>", "Description of the B document.", "</body>", "</html>"),
  file.path(tmp_dir, "b.html")
)
Sys.sleep(1)

writeLines(
  c("%PDF-1.4", "Digital surrogate of B."),
  file.path(tmp_dir, "b.pdf")
)
Sys.sleep(1)

writeLines(
  "Plain text transcription of B.",
  file.path(tmp_dir, "b.txt")
)

## ----makesnapshot-------------------------------------------------------------
rs001_snapshot_file <- snapshot_storage(
  path = tmp_dir,
  root = tmp_dir
)

## ----subsetsnapshot-----------------------------------------------------------
rs001_snapshot <- readRDS(rs001_snapshot_file)
rs001_snapshot$description <- c(
  "Description of Object A", "Image of Object A",
  "Description of Record B", "Surrogate of Record B", "OCR Text of Record B"
)
rs001_df <- rs001_snapshot[
  ,
  c("stem", "filename", "description", "quick_sig", "ctime")
]

## ----createrecordset----------------------------------------------------------
rs001 <- recordset_df(
  x = rs001_df,
  creator = utils::person("Jane", "Doe", role = "aut"),
  title = "Demonstrator Record Set",
  record_set_identifier = "http://example.com/archive/sets/rs001",
  description = "A demonstration of a record set",
  record_identifier = "stem",
  record_part_identifier = "filename"
)

## ----printrecordset-----------------------------------------------------------
print(rs001)

## ----recordlevel--------------------------------------------------------------
rs001$stem

## ----recorpart----------------------------------------------------------------
rs001$filename

