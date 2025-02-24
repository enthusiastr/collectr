#' Syntactic shortcut for adding an item to a collectr collection
#'
#' @description
#' Provides `+` as a shortcut for adding an item to a `collectr` collection.
#'
#' @param collection A `collectr` object
#' @param item A `collectr.item`
#'
#' @return A modified `collectr` collection with the new item.
#'
#' @export
"+.collectr" <- function(a, b) {
  if (inherits(a, "collectr") && inherits(b, "collectr.item")) {
    .collect(b, a)
  } else {
    stop(
      paste0(
        "Failed to add a class '",
        paste(class(b), collapse = "-"),
        "' to object a class '",
        paste(class(a), collapse = "-"),
        "' object. Unsupported combination of classes.\n")
    )
  }
}

#' Adds and item to a collection in the re-assign manner.
#'
#' @param lhs A `collectr` object.
#' @param rhs A `collectr.item` object.
#' @param lhs_name NULL or character(1), character is only propagated by a method call with shortcut = TRUE
#' @param shortcut logical(1) defaults to FALSE only set to TRUE by S3 method call
#'
#' @return collectr object, invisible, extended collectr collection.
#'
#' @export
"%++%" <- function(lhs, rhs, lhs_name = NULL, shortcut = FALSE) {
  if (!inherits(lhs, "collectr")) {
    stop(
      "You are trying to assign an item to a non-collectr object.
      Left-hand-side of the operator must be a collectr object."
    )
  }

  if (!inherits(rhs, "collectr.item")) {
    warning(
      paste0(
        "You are trying to add a '", class(rhs)[1], "' object to a collectr.
        Did you forget to wrap it into `collect()`?
        \nAttempting to convert it to 'collectr.item'."
      )
    )

    rhs <-
      structure(
        list(
          content = rhs,
          item_name = deparse(substitute(rhs))
        ),
        class = "collectr.item"
      )
  }

  if (!shortcut) {
    lhs_name <- deparse(substitute(lhs))
  }

  new_val <- .collect(rhs, lhs)
  assign(lhs_name, new_val, envir = parent.frame())
  invisible(new_val)
}
