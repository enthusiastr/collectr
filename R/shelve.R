#' Saves all the items in a collectr according to its options
#'
#' @param object collectr object, currently only supports 'collectr.gg'
#'
#' @returns invisible()
#'
#' @export
shelve <- function(object) {
  if (!inherits(object, "collectr")) stop(
    "save.collectr requires a collectr object."
  ) else if (inherits(object, "collectr.item")) stop(
    "save.collectr requires a collecor collection, not collectr.item."
  )

  if (inherits(object, "collectr.gg")) {
    n <- length(object$collection)
    if (n > 0) {
      lapply(
        X = 1:n,
        FUN = \(i) {
          item <-  object$collection[[i]]

          specific_options <- item$specific_options
          save_options <- object$general_options
          save_options[intersect(
            names(save_options),
            names(specific_options)
          )] <-
            specific_options[intersect(
              names(save_options),
              names(specific_options))]


          filename <- ifelse(
            is.null(save_options$filename),
            paste0(save_options$prefix, names(object$collection[i]), save_options$suffix),
            paste0(save_options$prefix, save_options$filename, save_options$suffix)
          )

          item_plot <- item$content

          if (!is.null(save_options$theme)) {
            item_plot <- item_plot + save_options$theme
          }

          if (!is.null(save_options$caption)) {
            item_plot <- item_plot + labs(title = save_options$caption)
          }

          tryCatch(
            expr = {
              ggsave(
                plot = item_plot,
                filename = paste0(filename, ".", save_options$type),
                path = save_options$path,
                device = save_options$type,
                width = save_options$width,
                height = save_options$height,
                scale = save_options$scale,
                units = save_options$units,
                dpi = save_options$dpi,
                create.dir = save_options$create.dir
              )
            },
            error = \(err) message(
              paste0(
                "\nFailed to save collection item '",
                names(object$collection)[i], "'.",
                " Reason: ", err, "\n"
              )
            )
          )
        }
      )
    }
    invisible()
  } else {
    stop(
      paste0(
        "save.colelctr does not yet support ", tail(class(object), 1), " objects."
      )
    )
  }
}
