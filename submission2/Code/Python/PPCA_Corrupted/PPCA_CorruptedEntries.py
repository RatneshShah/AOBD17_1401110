# This Code performs reconstruction of a corrupted Image using PPCA Approach
# Group - 10

import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from numpy.linalg import inv
import numpy as np
import PPCA
import skimage
from skimage import color
from math import *
from sklearn.metrics import *
from time import time

RGB = mpimg.imread("input_img.png")


RGB_noise = skimage.util.random_noise(RGB, mode='s&p', seed=None, clip=True, amount=0.10)
RGB_Gray = color.rgb2gray(RGB_noise)
plt.imshow(RGB_Gray, cmap = plt.cm.Greys_r)
plt.show()
RGB_new = color.rgb2gray(RGB)



# Required Number of Eigen Values
k = 20

# Applying PPCA with EM on data corrupted data matrix.
tic = time()
[W,sigma_square,Xn,t_mean,M] = PPCA.em_PPCA(RGB_Gray,k)
toc = time()
timediff = toc-tic

# Recovered Image
rec_Image = np.dot(np.dot(np.dot(W,inv(np.dot(W.T,W))),M),Xn)
rec_Image = rec_Image + np.dot((t_mean),np.ones((1,rec_Image.shape[1])))

plt.imshow(rec_Image, cmap = plt.cm.Greys_r)
plt.show()
rmse = sqrt(mean_squared_error(rec_Image,RGB_new))
print "rmse",rmse
print "time",timediff
