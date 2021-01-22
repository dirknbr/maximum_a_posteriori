
# http://www.mi.fu-berlin.de/wiki/pub/ABI/Genomics12/MLvsMAP.pdf slide 26

# argmax mu = argmax mu sum_x log(P(x | mu)) + log(P(mu))
# where P(mu) is the prior

# data
x <- c(1, 0, 1, 1, 1, 1, 0)

# beta prior

a <- 1
b <- 1

bern <- function(xi, mu) {
  return(mu ** xi * (1 - mu) ** (1 - xi))
}

bern(1, .5)

logpostdata <- c()
museq <- seq(0.01, .99, .01)
best <- -99999999999999

# loop over parameter
for (mu in museq) {


	logpost <- 0

	# loop over data

	for (xi in x) {
	  # mu <- a / (a + b)
	  logpost <- logpost + log(dbinom(xi, 1, mu)) + log(dbeta(mu, a, b))
	  # logpost <- logpost + log(bern(xi, a / (a + b))) + log(dbeta(mu, a, b))
	}
	logpostdata <- c(logpostdata, logpost)

	if (logpost > best) {
		best <- logpost
		cat(mu, logpost, '\n')
	}


 }

plot(museq, logpostdata)