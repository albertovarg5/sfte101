import numpy as np
import matplotlib.pyplot as plt

x = np.arange(-10, 11, 1)
y = x**2

plt.title("Parabola")
plt.xlabel("X Values")
plt.ylabel("Y = X Squared")

plt.plot(x, y, color='black', marker='o')
plt.grid()
plt.show()