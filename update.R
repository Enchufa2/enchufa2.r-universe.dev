#!/usr/bin/Rscript

db <- tools::CRAN_package_db()
db <- subset(db, grepl("Iñaki Ucar", Maintainer), c("Package", "URL"))

colnames(db) <- tolower(colnames(db))
db$url <- sapply(strsplit(db$url, ", "), tail, 1)

custom <- as.data.frame(matrix(c(
  "bmetr", "https://github.com/Enchufa2/bmetr",
  "units", "https://github.com/r-quantities/units"
), byrow=TRUE, ncol=2))
db <- rbind(db, setNames(custom, colnames(db)))

db <- with(db, db[order(url, package),])
cat(jsonlite::toJSON(db, pretty=TRUE), file="packages.json")
