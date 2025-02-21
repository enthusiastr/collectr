#' Add an item to a collectr collection
#'
#' @description
#' Adds an item to a collectr collection, either as a `collectr.item` object or a generic R object.
#'
#' @param item An object to be added. If not a `collectr.item`, it will be wrapped as one.
#' @param ... Named options for the new item's specific options.
#' @param collection A `collectr` object to add the item to. If NULL, a new `collectr.item` is created.
#'
#' @return A modified `collectr` object with the new item included.
#'
#' @export
collect <-
  function(
    item,
    ...,
    collection = NULL
  ) {
    item_name <- deparse(substitute(item))
    if (is.null(collection)) {
      if (!"collectr.item" %in% class(item)) {
        structure(
          list(
            content = item,
            specific_options = list(...),
            item_name = item_name
          ),
          class = "collectr.item"
        )
      } else {
        args <- list(...)
        options_to_update <- intersect(names(item$specific_options), names(args))
        specific_options <- args[options_to_update]
        structure(
          list(
            content = item$content,
            specific_options = specific_options,
            item_name = item_name
          ),
          class = "collectr.item"
        )
      }
    } else {
      .collect(
        collect(item, ...),
        collection,
        item_name
      )
    }
  }

#' Internal function to add an item to a collectr collection
#'
#' @description
#' Adds an item to an existing collectr collection. Not intended for direct use.
#'
#' @param item A `collectr.item` object or any R object.
#' @param collection A `collectr` object to which the item is added.
#' @param item_name character(1), the deparsed name of the item.
#'
#' @return A modified collectr object with the new item.
#' @keywords internal
.collect <-
  function(
    item,
    collection
  ) {
    current_collection <- collection$collection
    general_options <- collection$general_options
    new_item <- list()
    if ("collectr.item" %in% class(item)) {
      item_name <- item$item_name
      specific_options <- item$specific_options
      options_to_update <- intersect(names(general_options), names(specific_options))
      specific_options <- specific_options[options_to_update]
      new_item[[item_name]] <- list(
        content = item$content,
        specific_options = specific_options
      )
    }
    return(
      structure(
        list(
          collection = append(current_collection, new_item),
          general_options = general_options
        ),
        class = class(collection)
      )
    )
  }
