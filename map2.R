
# http://www.mi.fu-berlin.de/wiki/pub/ABI/Genomics12/MLvsMAP.pdf

# data
x <- c(1, 0, 1, 1, 1, 1, 0, -1, 2, 3, 4)
mean(x)

# x ~ N(mu, sigma)
# mu ~ N(0, 2)
# sigma ~ G(2, 1)

logpostdata <- c()
museq <- seq(-2, 2, .1)
sigmaseq <- seq(0.1, 3, .1)
best <- -99999999999999

log(dnorm(1, 1, 1))

logpostf <- function(mu, sigma) {
	logpost <- 0

	# loop over data

	for (xi in x) {
	  logpost <- logpost + log(dnorm(xi, mu, sigma)) + log(dnorm(mu, 0, 2)) + log(dgamma(sigma, 2, 1))
	}
	return(logpost)
}

# loop over parameter
for (mu in museq) {
  for (sigma in sigmaseq) {

	logpost <- logpostf(mu, sigma)
	logpostdata <- c(logpostdata, logpost)

	if (logpost > best) {
		best <- logpost
		cat(mu, sigma, logpost, '\n')
	}


 }
}

logpost <- outer(museq, sigmaseq, logpostf)

persp(museq, sigmaseq, logpost, zlim = c(-1000, 0), theta = 45, phi = 30, shade = .5)

# plot(museq, logpostdata)