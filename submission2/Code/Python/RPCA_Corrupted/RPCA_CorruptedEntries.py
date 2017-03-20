# This Code performs recovering of image having corrupted entries using Robust PCA
# Group - 10

import matplotlib.pyplot as plt
import matplotlib.image as mpimg
from numpy.linalg import *
import numpy as np
from r_pca import R_pca
import skimage
from skimage import color
from numpy import *
import time
from sklearn.metrics import *

RGB = mpimg.imread("input_img.png")
RGB_gray = color.rgb2gray(RGB)

RGB_noise = skimage.util.random_noise(RGB, mode='s&p', seed=None, clip=True, amount=0.10)
corr_img = color.rgb2gray(RGB_noise)
Lambda = 0.0625
tic = time.time()

rpca = R_pca(corr_img)
L, S = rpca.fit(max_iter=10000, iter_print=100)
toc = time.time()
plt.imshow(L, cmap = plt.cm.Greys_r)
plt.show()
plt.imshow(S, cmap = plt.cm.Greys_r)
plt.show()
plt.imshow(L+S, cmap = plt.cm.Greys_r)
plt.show()
rmse = sqrt(mean_squared_error(RGB_gray,L))
print "rmse",rmse
print "time",toc-tic
