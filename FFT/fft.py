import glob
import fft2, Image
import numpy as np

images = glob.glob('Dataset/*.jpg')

#fft1_matr = fft2.modifyFFT(images[0])
#fft2_matr = fft2.modifyFFT(images[1])

dict_im_fft = {}
for image in images:
	dict_im_fft[image] = fft2.modifyFFT(image)

#dist = np.linalg.norm(fft1_matr - fft2_matr)
#print dist

dist_matrix = []
closest_image_dict = {}
for image1 in images:
	arr = []
	fft_im1 = dict_im_fft[image1]
	for image2 in images:	
		fft_im2 = dict_im_fft[image2]
		dist = np.linalg.norm(fft_im1 - fft_im2)
		if (image1==image2):
			arr.append(float("inf"))
		else:
			arr.append(dist)

	closest_index = np.argmin(arr)
	closest_image_dict[image1] = images[closest_index]
	dist_matrix.append(arr)

import pylab
import matplotlib.cm as cm
#print len(dist_matrix[0])
#fWrite = open('closestImages','w')
for key in closest_image_dict.keys():
	#fWrite.write(str(key) + '	'+str(closest_image_dict[key])+'\n') 
	f = pylab.figure()
	for n, fname in enumerate((key, closest_image_dict[key])):
    		image=Image.open(fname).convert("L")
		arr=np.asarray(image)
		#f.add_subplot(2, 1, n)  # this line outputs images on top of each other
		f.add_subplot(1, 2, n)  # this line outputs images side-by-side
		pylab.imshow(arr,cmap=cm.Greys_r)
	pylab.title('Double image')
	pylab.show()
#fWrite.close()





#print images[0]
def plot_fft(fft):
	j = Image.fromarray(fft.astype(np.uint8))
	j.save('img1.png')
	return

#plot_fft(fft1_matr)
