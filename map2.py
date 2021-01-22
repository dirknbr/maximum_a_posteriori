
import numpy as np
from scipy.stats import norm, gamma

x = np.array([1, 0, 1, 1, 1, 1, 0, -1, 2, 3, 4])
print(np.mean(x))

logpostdata = []
museq = np.linspace(-2, 2, 20)
sigmaseq = np.linspace(0.1, 3, 20)
best = -999999999999

print(norm.logpdf(1, 1, 1))

def logpostf(mu, sigma):
  logpost = 0
  for xi in x:
  	# likelihood * prior
  	logpost += norm.logpdf(xi, mu, sigma) + norm.logpdf(mu, 0, 2) + gamma.logpdf(sigma, 2, 1)
  return logpost


for mu in museq:
  for sigma in sigmaseq:
    logpost = logpostf(mu, sigma)
    if logpost > best:
      best = logpost
      print(mu, sigma, logpost) 