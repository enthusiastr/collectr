.onLoad <- function(libname, pkgname) {
  # register the methods
  registerS3method("+", "collectr", collectr:::`+.collectr`)
  registerS3method("%++%", "collectr", \(lhs, rhs) collectr:::`%++%`(lhs, rhs, deparse(substitute(lhs)), TRUE))

  message("\nPackage collectr loaded successfully. Happy collectring!\n")
}
