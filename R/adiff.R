to_return = function(y){
  if(is.matrix(y)){v=as.matrix(val(y))} else {v = as.numeric(val(y))}
  attr(v, "gradient") = t(dvdx(y))
  return(v)
}

#' Automatic Differentiation Using Madness
#' 
#' A wrapper function to the functionality of the \code{madness} package. 
#' Converts a given \code{x} to a madness object and then applies \code{func} to
#' it, returning the result and the Jacobian for the transformation \code{func}.
#' \code{adiff} is used by the \code{\link{rjmcmcpost}} function.
#' 
#' @param func The function to be differentiated (usually user-defined). The 
#'   function cannot use vectorised behaviour for \code{x}. For example, 
#'   \code{c(x[1]/5, x[2]/5)} should be used in place of \code{x/5}.
#' @param x The values at which to evaluate the function \code{func}. Generally 
#'   a numeric vector but can also be a numeric matrix (or a single number).
#' @param ... Further arguments to be passed to \code{func}.
#' @return A numeric vector or matrix containing the result of the function 
#'   evaluation \code{func(x, ...)}. The \code{"gradient"} attribute of this 
#'   object contains the Jacobian matrix of the transformation \code{func}.
#'   
#' @seealso \code{\link{madness}}
#'   
#' @examples
#' x2x3 = function(x){
#' return(c(x^2, x^3))
#' }
#' 
#' y = adiff(x2x3, c(5,6))
#' attr(y, "gradient")
#' 
#' @references Pav, S. E. (2016) Madness: Automatic Differentiation of
#'   Multivariate Operations.
#'   
#' @import madness
#' @export
adiff = function(func, x, ...){
  if(is.matrix(x)){xa = array(x, rev(dim(x)))} else {xa = array(x, c(length(x),1))}
  madx = madness(xa)
  y = func(madx, ...)
  return(to_return(y))
}