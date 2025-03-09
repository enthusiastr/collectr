#' Add an item to a collectr collection
#'
#' @description
#' Either adds a `collectr.item` into a `collectr` or transforms an object that is not yet a `colelctr.item` into one.
#'
#' @param item a `collectr.item` to be added to a `collectr` or another R object to be converted into a `collectr.item`
#' @param ... Named options for the new item's specific options.
#' @param collection A `collectr` object to add the item to. If NULL, a new `collectr.item` is created.
#'
#' @return A new `collectr.item` object or a modified `collectr` object with the new item included.
#'
#' @export
collect <-
  function(
    item,
    ...,
    collection = NULL
  ) {
    args <- list(...)
    item_name <- ifelse(is.null(args$name), deparse(substitute(item)), args$name)
    if (is.null(collection)) {
      if (!inherits(item, "collectr.item")) {
        structure(
          list(
            content = item,
            specific_options = list(...),
            item_name = item_name
          ),
          class = "collectr.item"
        )
      } else {
        item
      }
    } else {
      if (!inherits(item, "collectr.item")) {
        options_to_update <- intersect(names(collection$general_options), names(args))
        specific_options <- args[options_to_update]
        item <-
          structure(
            list(
              content = item,
              specific_options = specific_options,
              item_name = deparse(substitute(item))
            ),
            class = "collectr.item"
          )
        .collect(
          item,
          collection
        )
      } else {
        options_to_update <- intersect(names(item$specific_options), names(args))
        specific_options <- args[options_to_update]
        item <-
          structure(
            list(
              content = item$content,
              specific_options = specific_options,
              item_name = item$item_name
            ),
            class = "collectr.item"
          )
        .collect(
          item,
          collection
        )
      }
    }
  }

#' Internal function to add an item to a collectr collection
#'
#' @description
#' Adds an item to an existing collectr collection. Not intended for direct use.
#'
#' @param item A `collectr.item` object
#' @param collection A `collectr` object to which the item is added.
#'
#' @return A modified collectr object with the new item.
#'
#' @keywords internal
.collect <-
  function(
    item,
    collection
  ) {
    if (!any(paste0("collectr.", class(item$content)) %in% class(collection))) {
      stop(
        paste0(
          "Cannot add items of class: ", paste(class(item$content), collapse = ", "),
          ", to a collection of class: ", tail(class(collection), 1), ".\n"
        )
      )
    }

    current_collection <- collection$collection
    general_options <- collection$general_options
    item_name <- item$item_name
    specific_options <- item$specific_options
    options_to_update <- intersect(names(general_options), names(specific_options))
    specific_options <- specific_options[options_to_update]
    new_item <- list()
    new_item[[item_name]] <- list(
      content = item$content,
      specific_options = specific_options
    )
    if (is.null(current_collection[[item_name]])) {
      return(
        structure(
          list(
            collection = append(current_collection, new_item),
            general_options = general_options
          ),
          class = class(collection)
        )
      )
    } else {
      warning(
        paste0(
          "Item ", item_name,
          " already exists in the collection ", deparse(substitute(collection)),
          " and will be ovewrwritten.
          Have you forgotten to set the 'name' when collecting?")
      )
      current_collection[[item_name]] <- new_item[[item_name]]
      return(
        structure(
          list(
            collection = current_collection,
            general_options = general_options
          ),
          class = class(collection)
        )
      )
    }
  }
