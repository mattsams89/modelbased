% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{as.numeric_ifnumeric}
\alias{as.numeric_ifnumeric}
\title{Convert to Numeric if Possible}
\usage{
as.numeric_ifnumeric(x)
}
\arguments{
\item{x}{A vector to be converted.}
}
\value{
Numeric
}
\description{
Tries to convert vector to numeric if possible. Otherwise, leaves it as is.
}
\examples{
as.numeric_ifnumeric(c("1", "2"))
as.numeric_ifnumeric(c("1", "2", "A"))
}
