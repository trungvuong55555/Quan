#Write a function compute_s_n that for any given n computes the sum Sn=12+22+32+???+n2.
#Report the value of the sum when n=10.

compute_s_n <- function(n){
  x <- 1:n
  sum(x^2)
}
compute_s_n(10)