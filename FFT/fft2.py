import numpy as np
import Image
'''
f = lambda t: 2*np.cos(4*2*np.pi*t) + 5*np.sin(10*2*np.pi*t)
n = 256
r = np.arange(0.0,1.0,1.0/n)
s = f(r)
'''



def modifyFFT(im):
	i = Image.open(im)
	#i = Image.open('1.jpg')
	i = i.convert('L')    #convert to grayscale
	s = np.asarray(i) # to array


	F = np.fft.rfft2(s)
	print F
	print F.shape # 256*129
	n = 256
	m = n/2
	p = lambda z: (abs(np.real(z))/m,abs(np.imag(z))/m)

	t = [p(r) for r in F] # t is 256*2*129 array of tuples of (amplitude,frequency)
	#print len(t[0][0])
	#t = p(F)
	#print np.transpose(F).shape


	import heapq
	def minkval(a,k):
		v = np.sort(a)
		#print v[0:5]
		#print v[k]
		return v[k] 

	sin_freq = []
	cos_freq = []
	for j in range(0,256):
		mean1 = np.mean(t[j][0])
		#print "mean1 " + str(mean1) 
		mean2 = np.mean(t[j][1])
		#print "mean2 " + str(mean2) 
		cutoff1 = mean1#minkval(t[j][0],64)
		#print "cutoff1 " + str(cutoff1) 
		cutoff2 = mean2#minkval(t[j][1],64)
		#print "cutoff2 " + str(cutoff2) 
	
		for i in range(0,len(t[j][0])):
			if(t[j][0][i] < cutoff1):
				#print str(t[j][0][i]) + '*cos(' + str(i) + '*2*pi*t)'
				F[j][i]=0
			else:
				cos_freq.append(i)   # ????
			if(t[j][1][i] < cutoff2):
				#print str(t[j][1][i]) + '*sin(' + str(i) + '*2*pi*t)'
				F[j][i]=0
			else:
				sin_freq.append(i)   # ????
			#print '________________--'


	#print sin_freq

	c = np.fft.irfft2(F) # take the inverse fft
	return c
#print c
#j = Image.fromarray(c.astype(np.uint8))
#j.save('img1.png')




#i = Image.open('1.jpg')
modifyFFT('1.jpg');

