import numpy as np
import Image


def modifyFFT(im):
	i = Image.open(im)
	i = i.convert('L')    #convert to grayscale
	s = np.asarray(i) # to array


	F = np.fft.rfft2(s)
	print F
	#print F.shape # 256*129
	n = 256
	m = n/2
	p = lambda z: (abs(np.real(z))/m,abs(np.imag(z))/m)

	t = [p(r) for r in F] # t is 256*2*129 array of tuples of (amplitude,frequency)


	import heapq
	def minkval(a,k):
		v = np.sort(a)
		return v[k] 

	sin_freq = []
	cos_freq = []
	for j in range(0,256):
		mean1 = np.mean(t[j][0])
		mean2 = np.mean(t[j][1])
		cutoff1 = mean1
		cutoff2 = mean2
	
		for i in range(0,len(t[j][0])):
			if(t[j][0][i] < cutoff1):
				F[j][i]=0
			else:
				cos_freq.append(i)   # ????
			if(t[j][1][i] < cutoff2):
				F[j][i]=0
			else:
				sin_freq.append(i)   # ????



	c = np.fft.irfft2(F) # take the inverse fft
	return c





i = Image.open('1.jpg')
modifyFFT('1.jpg');

