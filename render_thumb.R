#!/usr/bin/env Rscript
pdftools::pdf_render_page("template.pdf", dpi=72) |>
  png::writePNG("thumb.png")
