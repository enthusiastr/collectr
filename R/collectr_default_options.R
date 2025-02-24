#' Default options for collectr collections
#'
#' @description
#' Returns default options for collectr based on a specified family.
#'
#' @param family character(1) or NULL, must be one of `collectr_families(quite=TRUE)`, or NULL to return general defaults.
#'
#' @return A named list of default options, including `"save_path"` and `"file"`. If a family is provided, additional parameters may be included.
#'
#' @export
collectr_default_options <-
  function(
    family = NULL
  ) {
    options <-
      list(
        save_path = getwd(),
        file = NULL,
        prefix = "",
        suffix = ""
      )

    if (!is.null(family)) {
      if (family %in% collectr_families(TRUE)) {
        if (family == "ggplot") {
          if (!requireNamespace("ggplot2", quietly = TRUE)) {
            warning("Package 'ggplot2' is required but not installed. Install it before sing collectr with ggplot objects.")
          }
          options <-
            append(
              options,
              list(
                type = "png",
                width = 1024,
                height = 768,
                units = "px",
                ppi = 72,
                theme = NULL,
                caption = NULL
              )
            )
        }
      } else {
        stop(
          paste0("Unsupported family: '", family, "'.\n See collectr_families(quite=FALSE) to see supported families.")
        )
      }
    }

    return(options)
  }
