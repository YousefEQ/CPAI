import numpy as np
import matplotlib.pyplot as plt

# Define the activation function
def sign(x):
    return np.where(x >= 0, 1, -1)

# Define the inputs and outputs for training
X = np.array([[1.0, 1.0, 1.0],
              [9.4, 6.4, 1.0],
              [2.5, 2.1, 1.0],
              [8.0, 7.7, 1.0],
              [0.5, 2.2, 1.0],
              [7.9, 8.4, 1.0],
              [7.0, 7.0, 1.0],
              [2.8, 0.8, 1.0],
              [1.2, 3.0, 1.0],
              [7.8, 6.1, 1.0]])

d = np.array([1, -1, 1, -1, 1, -1, -1, 1, 1, -1])

# Define the initial weights
W = np.array([0.75, 0.5, -0.6])

# Define the learning rate
c = 0.2

# Train the network for multiple iterations and track the error rate
max_iterations = 1000
error_rate = np.zeros(max_iterations)
for i in range(max_iterations):
    error_count = 0
    for j in range(len(X)):
        x = X[j]
        y = sign(np.dot(W, x))
        if y != d[j]:
            error_count += 1
        W = W + c * (d[j] - y) * x
    error_rate[i] = error_count / len(X)

# Plot the error rate as a function of the number of iterations
plt.plot(range(1, max_iterations+1), error_rate)
plt.xlabel("Number of iterations")
plt.ylabel("Error rate")
plt.show()
