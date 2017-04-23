import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data
from numpy.linalg import inv
import PPCA
import matplotlib.pyplot as plt
import numpy as np
import csv
mnist = input_data.read_data_sets('/home/ratnesh/Desktop/dnn/data', one_hot=True)

x_train = mnist.train.images[:50,:]
y_train = mnist.train.labels[:50,:]
for i in range(50):

            if y_train[i,1]==1:
                try:
                    img = x_train[i].reshape(28, 28)

                    [W,sigma_square,Xn,t_mean,M] = PPCA.em_PPCA(img,5)
                    #print np.dot(np.transpose(Xn),M).shape
                    rec_Image = np.dot(np.dot(np.dot(W,inv(np.dot(W.T,W))),M),Xn)
                    n1 = np.dot(W,inv(np.dot(W.T,W)))
                    n2 = np.dot(M,Xn)
                    rec_Image2 = np.dot(n1,n2)
                    plt.imshow(rec_Image, cmap = plt.cm.Greys_r)
                    plt.show()
                    W = W.flatten()
                    M_X = n2.flatten()
                  #  with open('/home/ratnesh/Desktop/AOBD FINAL/akshat/ppcas.csv', 'a') as csvfile:
                  #      ppca_writer = csv.writer(csvfile)
                  #      ppca_writer.writerow(W)
                  #  with open('/home/ratnesh/Desktop/AOBD FINAL/akshat/weights.csv', 'a') as csvfile:
                  #      ppca_writer = csv.writer(csvfile)
                  #      ppca_writer.writerow(M_X)
                except np.linalg.LinAlgError:
                            print "Singular error"
                            continue
