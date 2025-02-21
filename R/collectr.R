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
    families <- c("ggplot", "flextable", "gt")

    if (!quite) {
      cat("\nCollectr families description TBA.\n\n")
    }

    return(families)
  }

#' Default options for collectr collections
#'
#' @description
#' Returns default options for collectr based on a specified family.
#'
#' @param family character(1), must be one of `collectr_families()`, or NULL to return general defaults.
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
        file = NULL
      )

    if (!is.null(family)) {
      if (family %in% collectr_families(TRUE)) {
        options <-
          append(
            options,
            type = "png"
          )
      } else {
        stop(
          paste0("Invalid family: '", family, "'.\nUse collectr_families() to see valid families.")
        )
      }
    }

    return(options)
  }

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
