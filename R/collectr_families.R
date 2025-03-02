#' Supported families of collectr collections
#'
#' @description
#' Returns a character vector of available collectr families that can be used to configure collections.
#'
#' @param quiet logical(1), defaults to FALSE. If TRUE, suppresses the message describing available families.
#'
#' @return character vector of supported collectr families.
#'
#' @export
collectr_families <-
  function(
    quite = FALSE
  ) {
    families <- c("gg")

    if (!quite) {
      cat(
        "::: Collection Families in collectr :::\n\n",
        "The `collectr` package provides structured collection systems for efficiently managing and saving various types of objects. ",
        "Each collection family is designed to streamline the handling of a specific type of output, ensuring consistency, automation, and easy retrieval.\n\n",

        "(1) 🎨 collectr.gg – Managing ggplot2 Collections\n\n",
        "family = \"gg\"\n\n",
        "The `collectr.gg` class simplifies the process of collecting multiple `ggplot2` objects and saving them efficiently. ",
        "It allows users to store plots in a structured way and automatically export them to a predefined location with customizable options, ",
        "such as file format (PNG, PDF, SVG), graphical device, resolution, DPI, and filename conventions. ",
        "This ensures that visualization outputs are systematically organized and reproducible.\n\n",

        "(2) (Coming Soon) 📊 collectr.flex – Managing flextable Collections\n\n",
        "family = \"flex\"\n\n",
        "Planned support for `flextable` objects will allow structured collection and automated exporting of styled tables into common document formats ",
        "such as Word (`.docx`), PowerPoint (`.pptx`), and PDF. ",
        "This will enable seamless integration of formatted tables into reports and presentations.\n\n",

        "(3) (Coming Soon) 📊 collectr.gt – Managing gt Table Collections\n\n",
        "family = \"gt\"\n\n",
        "Future support for `gt` tables will provide an efficient way to collect, organize, and export high-quality tables for reports. ",
        "Users will be able to predefine output formats such as HTML, PNG, or LaTeX, ensuring consistency in table presentations.\n"
      )
      invisible(families)
    } else {
      return(families)
    }
  }
