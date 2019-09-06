#' Model Parameters for Zero-Inflated Models
#'
#' Parameters of zero-inflated models.
#'
#' @param model A model with zero-inflation component.
#' @inheritParams model_parameters.lm
#' @inheritParams model_simulate
#'
#' @examples
#' library(parameters)
#' library(pscl)
#'
#' data("bioChemists")
#' model <- zeroinfl(art ~ fem + mar + kid5 + ment | kid5 + phd, data = bioChemists)
#' model_parameters(model)
#' @return A data frame of indices related to the model's parameters.
#' @inheritParams model_simulate
#' @export
model_parameters.zeroinfl <- function(model, ci = .95, standardize = "refit", standardize_robust = FALSE, bootstrap = FALSE, iterations = 1000, component = c("all", "conditional", "zi", "zero_inflated"), ...) {
  component <- match.arg(component)

  # fix argument, if model has no zi-part
  if (!insight::model_info(model)$is_zero_inflated && component != "conditional") {
    component <- "conditional"
  }


  # Processing
  if (bootstrap) {
    parameters <- parameters_bootstrap(model, iterations = iterations, ci = ci, ...)
  } else {
    parameters <- .extract_parameters_generic(model, ci = ci, component = component, ...)
  }


  # Standardized
  if (isTRUE(standardize)) {
    warning("Please set the `standardize` method explicitly. Set to \"refit\" by default.")
    standardize <- "refit"
  }

  if (!is.null(standardize) && !is.logical(standardize)) {
    parameters <- cbind(parameters, parameters_standardize(model, method = standardize, robust = standardize_robust)[2])
  }


  attr(parameters, "pretty_names") <- format_parameters(model)
  attr(parameters, "ci") <- ci
  class(parameters) <- c("parameters_model", "see_parameters_model", class(parameters))
  parameters
}


#' @export
model_parameters.hurdle <- model_parameters.zeroinfl

#' @export
model_parameters.zerocount <- model_parameters.zeroinfl