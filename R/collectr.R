#' Collectr wrapper
#'
#' @param family character(1), must be one of collectr_families() or NULL
#' @param ... options to be substituted on top of the collectr_default_options(family)
#'
#' @returns structure of class collectr and sub-classes by family
#'
#' @export
collectr <-
  function(
    family = NULL,
    ...
  ) {
    args <- list(...)
    options <- collectr_default_options(family = family)

    # Only update options that exist
    options_to_update <- intersect(names(args), names(options))
    if (length(options_to_update) > 0) {
      options[options_to_update] <- args[options_to_update]
    }

    # Warn if there are unused arguments
    unused_args <- setdiff(names(args), names(options))
    if (length(unused_args) > 0) {
      warning(
        "Unused arguments: ", paste(unused_args, collapse = ", "),
        ".\nUse names(collectr_default_options()) to see available options."
      )
    }

    # Class to set
    classes <-
      if (is.null(family)) {
        "collectr"
      } else {
        c("collectr", paste0("collectr.", family))
      }

    structure(
      list(
        collection = list(),
        general_options = options
      ),
      class = classes
    )
  }
