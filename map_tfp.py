
import numpy as np
import tensorflow.compat.v2 as tf
tf.enable_v2_behavior()
import tensorflow_probability as tfp
from tensorflow_probability import distributions as tfd

x = np.array([1., 0, 1, 1, 1, 1, 0, -1, 2, 3, 4])
print(np.mean(x))

mu = tf.Variable(0., name='mu')
# TODO: constrain sigma to positive or use bijector
sigma = tf.Variable(2., name='sigma')

model = tfd.Normal(mu, sigma)

mu_prior = tfd.Normal(0, 2)
sigma_prior = tfd.Gamma(2, 1)

def log_prob():
  return mu_prior.log_prob(mu) + sigma_prior.log_prob(sigma) + model.log_prob(x)

optimizer = tf.keras.optimizers.Adam(learning_rate=1.)

@tf.function(autograph=False)
def train_op():
  with tf.GradientTape() as tape:
    neg_log_prob = -tf.reduce_sum(log_prob())
  grads = tape.gradient(neg_log_prob, [mu, sigma])
  optimizer.apply_gradients(zip(grads, [mu, sigma]))
  return neg_log_prob, mu, sigma

for step in range(201):
  loss, mu_hat, sigma_hat = [t.numpy() for t in train_op()]
  if step % 20 == 0:
    print("step {}: log prob {} values {}".format(step, -loss, (mu_hat, sigma_hat)))