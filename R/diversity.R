# copy of OasisR::HLoc since its dependency on seg package is broken
# Normalized local diversity index, based on Shannon index / entropy
# takes a data frame of counts by demographic group, no total
#' @title Local normalized diversity index
#' @description This is a rewrite of `OasisR::HLoc`, an implementation of the Shannon-Weiner entropy-based diversity index. It takes a data frame of population counts (not shares!), where each row is one location and each column is a mutually exclusive demographic group. It then returns the index for each location.
#' @param x A data frame containing only numeric columns, where each column represents counts of population groups
#' @return A numeric vector of index values, with length the same as the number of rows in `x`
#' @examples
#'   race <- data.frame(white = c(3394, 3036, 1527),
#'                      black = c(13, 779, 448),
#'                      latino = c(38, 99, 125),
#'                      asian = c(0, 18, 34),
#'                      other_race = c(29, 120, 170))
#'  diversity(race)
#' @export
#' @rdname diversity
#' @seealso [OasisR::HLoc]
#'
#' @import cli
diversity <- function(x) {
  if (!any(x > 1)) {
    cli::cli_abort("{.var x} should be counts, but these seem like percentages.")
  }
  if (ncol(x) < 2) {
    cli::cli_abort("This function requires at least 2 columns.")
  }
  if (!all(sapply(x, is.numeric))) {
    cli::cli_abort("All columns in {.var x} should be numeric.")
  }
  if (!inherits(x, "data.frame")) {
    cli::cli_abort("{.var x} should be a data frame.")
  }
  # total number of groups
  n_grps <- ncol(x)
  # total pop in location i
  t_i <- rowSums(x)
  # share of pop in location i
  p_i <- x / t_i
  logs <- log(p_i)
  p_log_p <- p_i * logs
  h_i <- rowSums(p_log_p, na.rm = TRUE)
  -h_i / log(n_grps)
}
