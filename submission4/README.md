This Submission contains the files for Generative Adverserial Networks using PPCA:

Folder 1: Fer2013
 	
	FactorAnalysis.py --> Generates the PC using PPCA on the Fer2013 dataset
	GanPCA.py	  --> Contains the GAN model described in the report.
	ppca_model_30000.py-> Contains the extracted pc and this file is used to train discriminator
	generator_1000.npy--> Contains the 16 samples of the fake generated PC at the 1000th iteration
	generator_5000.npy--> Contains the 16 samples of the fake generated PC at the 5000th iteration	
	generator_8000.npy--> Contains the 16 samples of the fake generated PC at the 8000th iteration
	

Folder 2: MNIST

	GanPca_W.py	  --> GAN Model to generate W
	GanPCA_Xn_M.py	  --> GAN Model to generate Xn*M
	FactorAnalysis.py --> Generates the PC and M*Xn using PPCA-EM Algorithm from Bishop on the MNIST dataset
	generator_mnist_50_W.npy--> Contains the 16 samples of the fake generated PC at the 50th iteration
	generator_mnist_50_Xn_M.npy--> Contains the 16 samples of the fake generated M*Xn at the 50th iteration
	index_batch_random.npy --> random generated 1000 batches each consisting randomly generated indexes to train the Discriminator
	PPCA.py 	  --> PPCA_EM Algorithm implemented from Bishop Paper
	ppca_model_W.npy  --> Extracted W using the above algorithm
	ppca_model_Xn_M.npy  --> Extracted M*Xn using the above algorithm
	plot_image.py	  --> Recreates the image from the output of generators of both the models.

Folder 3: Results:

	Contains the recreated images of the mnist dataset which we obtained.


gen_ppca_mnist.py --> Sample Test code initially used to generate image from pc directly without use of GAN.

PPCA.py 	  --> Implementation of PPCA_EM from Bishop.

