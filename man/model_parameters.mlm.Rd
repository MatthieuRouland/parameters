% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/model_parameters.multinom.R
\name{model_parameters.mlm}
\alias{model_parameters.mlm}
\alias{model_parameters.multinom}
\alias{model_parameters.bracl}
\alias{model_parameters.DirichletRegModel}
\alias{model_parameters.clm2}
\title{Parameters from multinomial or cumulative link models}
\usage{
\method{model_parameters}{mlm}(
  model,
  ci = 0.95,
  bootstrap = FALSE,
  iterations = 1000,
  standardize = NULL,
  exponentiate = FALSE,
  p_adjust = NULL,
  verbose = TRUE,
  ...
)

\method{model_parameters}{multinom}(
  model,
  ci = 0.95,
  bootstrap = FALSE,
  iterations = 1000,
  standardize = NULL,
  exponentiate = FALSE,
  p_adjust = NULL,
  verbose = TRUE,
  ...
)

\method{model_parameters}{bracl}(
  model,
  ci = 0.95,
  bootstrap = FALSE,
  iterations = 1000,
  standardize = NULL,
  exponentiate = FALSE,
  p_adjust = NULL,
  verbose = TRUE,
  ...
)

\method{model_parameters}{DirichletRegModel}(
  model,
  ci = 0.95,
  bootstrap = FALSE,
  iterations = 1000,
  component = c("all", "conditional", "precision"),
  standardize = NULL,
  exponentiate = FALSE,
  verbose = TRUE,
  ...
)

\method{model_parameters}{clm2}(
  model,
  ci = 0.95,
  bootstrap = FALSE,
  iterations = 1000,
  component = c("all", "conditional", "scale"),
  standardize = NULL,
  exponentiate = FALSE,
  p_adjust = NULL,
  verbose = TRUE,
  ...
)
}
\arguments{
\item{model}{A model with multinomial or categorical response value.}

\item{ci}{Confidence Interval (CI) level. Default to 0.95 (95\%).}

\item{bootstrap}{Should estimates be based on bootstrapped model? If \code{TRUE}, then arguments of \link[=model_parameters.stanreg]{Bayesian regressions} apply (see also \code{\link[=bootstrap_parameters]{bootstrap_parameters()}}).}

\item{iterations}{The number of bootstrap replicates. This only apply in the case of bootstrapped frequentist models.}

\item{standardize}{The method used for standardizing the parameters. Can be \code{"refit"}, \code{"posthoc"}, \code{"smart"}, \code{"basic"}, \code{"pseudo"} or \code{NULL} (default) for no standardization. See 'Details' in \code{\link[effectsize]{standardize_parameters}}. Note that robust estimation (i.e. \code{robust=TRUE}) of standardized parameters only works when \code{standardize="refit"}.}

\item{exponentiate}{Logical, indicating whether or not to exponentiate the the coefficients (and related confidence intervals). This is typical for, say, logistic regressions, or more generally speaking: for models with log or logit link. \strong{Note:} standard errors are also transformed (by multiplying the standard errors with the exponentiated coefficients), to mimic behaviour of other software packages, such as Stata.}

\item{p_adjust}{Character vector, if not \code{NULL}, indicates the method to adjust p-values. See \code{\link[stats]{p.adjust}} for details.}

\item{verbose}{Toggle warnings and messages.}

\item{...}{Arguments passed to or from other methods. For instance, when \code{bootstrap = TRUE}, arguments like \code{ci_method} are passed down to \code{\link[bayestestR]{describe_posterior}}.}

\item{component}{Model component for which parameters should be shown. May be one of \code{"conditional"}, \code{"precision"} (\pkg{betareg}), \code{"scale"} (\pkg{ordinal}), \code{"extra"} (\pkg{glmx}), \code{"marginal"} (\pkg{mfx}), \code{"conditional"} or \code{"full"} (for \code{MuMIn::model.avg()}) or \code{"all"}.}
}
\value{
A data frame of indices related to the model's parameters.
}
\description{
Parameters from multinomial or cumulative link models
}
\details{
Multinomial or cumulative link models, i.e. models where the
  response value (dependent variable) is categorical and has more than two
  levels, usually return coefficients for each response level. Hence, the
  output from \code{model_parameters()} will split the coefficient tables
  by the different levels of the model's response.
}
\examples{
library(parameters)
if (require("brglm2")) {
  data("stemcell")
  model <- bracl(
    research ~ as.numeric(religion) + gender,
    weights = frequency,
    data = stemcell,
    type = "ML"
  )
  model_parameters(model)
}
}
\seealso{
\code{\link[insight:standardize_names]{standardize_names()}} to rename
  columns into a consistent, standardized naming scheme.
}
