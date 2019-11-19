#' @importFrom emmeans emmeans ref_grid
#' @importFrom insight find_predictors get_data
#' @keywords internal
.emmeans_wrapper <- function(model, levels = NULL, fixed = NULL, modulate = NULL, transform = "response", length = 10, type = "mean", ...) {
  if (is.null(levels)) {
    levels <- insight::find_predictors(model)$conditional
    numeric <- levels[sapply(insight::get_data(model)[levels], is.numeric)]
    levels <- levels[!levels %in% numeric]
  } else {
    numeric <- NULL
  }

  if (!is.null(fixed)) {
    fixed <- unique(c(fixed, numeric))
    levels <- levels[!levels %in% fixed]
    if (!is.null(modulate)) {
      fixed <- fixed[!fixed %in% c(modulate)]
    }
  }

  if (length(levels) == 0) {
    stop("No suitable factor levels detected.")
  }


  # Posteriors
  if (is.null(modulate)) {
    means <- emmeans::emmeans(model, levels, by = fixed, transform = transform, ...)
  } else {
    at <- insight::get_data(model)[c(levels, modulate)]
    at <- sapply(at, visualisation_matrix, length = length, simplify = FALSE)
    means <- emmeans::ref_grid(model, at = at, by = c(fixed, modulate))
    if (type == "mean") {
      means <- emmeans::emmeans(means, c(levels, modulate), transform = transform)
    } else {
      means <- emmeans::emmeans(means, levels, by = c(fixed, modulate), transform = transform, ...)
    }
  }

  list(
    "means" = means,
    "levels" = levels,
    "fixed" = fixed,
    "modulate" = modulate
  )
}

#' @keywords internal
.clean_emmeans_frequentist <- function(means) {
  names(means)[names(means) == "emmean"] <- "Mean"
  names(means)[names(means) == "prob"] <- "Probability"
  names(means)[names(means) == "estimate"] <- "Difference"
  names(means)[names(means) == "t.ratio"] <- "t"
  names(means)[names(means) == "z.ratio"] <- "z"
  names(means)[names(means) == "p.value"] <- "p"
  names(means)[names(means) == "lower.CL"] <- "CI_low"
  names(means)[names(means) == "upper.CL"] <- "CI_high"
  names(means)[names(means) == "asymp.LCL"] <- "CI_low"
  names(means)[names(means) == "asymp.UCL"] <- "CI_high"
  means
}