% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/estimate_slopes.R
\name{estimate_slopes.lm}
\alias{estimate_slopes.lm}
\title{Estimate the slopes of a numeric predictor (over different factor levels)}
\usage{
\method{estimate_slopes}{lm}(
  model,
  trend = NULL,
  levels = NULL,
  transform = "response",
  standardize = TRUE,
  standardize_robust = FALSE,
  ci = 0.95,
  ...
)
}
\arguments{
\item{model}{A statistical model.}

\item{trend}{A character indicating the name of the numeric variable for which to compute the slopes.}

\item{levels}{A character vectors indicating the variables over which the slope will be computed. If NULL (default), it will select all the remaining predictors.}

\item{transform}{Can be \code{"none"} (default for contrasts), \code{"response"} (default for means), \code{"mu"}, \code{"unlink"}, \code{"log"}. \code{"none"}  will leave the values on scale of the linear predictors. \code{"response"} will transform them on scale of the response variable. Thus for a logistic model, \code{"none"} will give estimations expressed in log-odds (probabilities on logit scale) and \code{"response"} in terms of probabilities.}

\item{standardize}{If \code{TRUE}, adds standardized differences or coefficients.}

\item{standardize_robust}{Robust standardization through \code{MAD} (Median Absolute Deviation, a robust estimate of SD) instead of regular \code{SD}.}

\item{ci}{Credible Interval (CI) level. Default to 0.89 (89\%). See \code{\link[bayestestR]{ci}} for further details.}

\item{...}{Arguments passed to or from other methods.}
}
\description{
Estimate the slopes of a numeric predictor (over different factor levels)
}
\examples{
library(modelbased)

model <- lm(Sepal.Width ~ Species * Petal.Length, data = iris)
estimate_slopes(model)
}
