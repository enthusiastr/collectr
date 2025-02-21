
#' Syntactic shortcut for adding an item to a collectr collection
#'
#' @description
#' Provides `+` as a shortcut for adding an item to a `collectr` collection.
#'
#' @param collection A `collectr` object.
#' @param item A `collectr.item` or another object to add.
#'
#' @return A modified `collectr` collection with the new item.
#'
#' @export
`+.collectr` <-
  function(
    collection,
    item
  ) {
    if ("collectr" %in% class(collection)) {
      if ("collectr.item" %in% class(item)) {
        .collect(item, collection)
      } else {
        new_item <-
          structure(
            list(
              content = item,
              item_name = deparse(substitute(item))
            ),
            class = "collectr.item"
          )
        .collect(new_item, collection)
      }
    }
  }
