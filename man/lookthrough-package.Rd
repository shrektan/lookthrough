% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/lkthr.R
\docType{package}
\name{lookthrough-package}
\alias{lookthrough}
\alias{lookthrough-package}
\title{lookthrough: look-through the portfolio exposure}
\description{
The portfolio may invest in collective investment undertakings (ICU) or
investments packaged such as funds. In such case, only using the look-through
approach can the managers have a true undertanding of the portfolio exposure.
lookthrough is a simple package that helps you understand the exposure and
calculate aggregated numbers.
}
\details{
The implementation takes advantage of the
\href{https://github.com/gluc/data.tree}{data.tree} package, which is suitable for
this kind of problems. The users are supposed to be familiared with the data.tree
package. For those who are not, I strongly suggest to skim the vignettes of data.tree
(see the references below).
}
\references{
\itemize{
\item \href{https://CRAN.R-project.org/package=data.tree/vignettes/data.tree.html}{Quick introduction to data.tree}
\item \href{https://CRAN.R-project.org/package=data.tree/vignettes/applications.html}{Example applications of data.tree}
\item \href{https://www.centralbank.ie/docs/default-source/Regulation/industry-market-sectors/insurance-reinsurance/solvency-ii/communications/solvency-ii-information-notes/solvency-ii-information-note-9-look-through-of-collective-investment-undertakings-in-template-s-06-03.pdf?sfvrsn=2}{Solvency II Information Note 9 - Look-through of Collective Investment Undertakings in template S.06.03}
\item \href{http://www.dilloneustace.ie/download/1/Publications/Insurance/Solvency\%20II\%20Look-Through.pdf}{Solvency II Look-Through}
}
}
\seealso{
Useful links:
\itemize{
  \item \url{https://github.com/shrektan/lookthrough}
  \item Report bugs at \url{https://github.com/shrektan/lookthrough/issues}
}

}
\author{
\strong{Maintainer}: Xianying Tan \email{shrektan@126.com}

}
