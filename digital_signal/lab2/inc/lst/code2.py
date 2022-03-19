import matplotlib.pyplot as plt
import numpy as np
from scipy.signal import chirp, spectrogram, periodogram
from scipy.fft import fft, ifft, fftshift
from pylab import *
import os

def f(t):
    return (np.exp(-t) * np.cos(2*np.pi*t) + 1)

A0 = 2
A  = 3
fmin = 2
fmax = 10
f0 = 15
fd = 100
tmin = -1
tmax = 4
dt = tmax - tmin
N = dt * fd

def tripuls(t,tau, phi):
    x = np.zeros(len(t))
    idx = np.where(np.logical_and(t>=-tau/2 + phi, t<=0  + phi))
    x[idx] = (t[idx]+tau/2+ phi)/(tau/2+ phi)
    idx = np.where(np.logical_and(t<tau/2 + phi, t>0 + phi))
    x[idx] = -(t[idx]-tau/2- phi)/(tau/2 + phi)
    return x

xd = np.linspace(tmin, tmax, N)
zd = A * tripuls(xd, 0.1, 1)
plt.figure()
plt.subplot(211)
plt.plot(xd, zd, 'k')
plt.show()


def pulstran(t, count, tau, tau_count):
    x = np.zeros(len(t))
    for i in range(1, count + 1, 1):
        x += tripuls(t, tau, tau_count * i)
    return x / 2

zd = A * pulstran(xd, 4, 0.1, 0.3)
plt.figure()
plt.subplot(211)
plt.plot(xd, zd, 'k')
plt.show()

w = chirp(xd[::-1], fmax, fmin, tmax, method='linear')
plt.figure()
plt.subplot(111)
plt.xlim([0, 4])
plt.plot(xd, -w)
plt.show()

zd = A0+A*np.sin(2*np.pi*f0*xd)

plt.figure()
plt.subplot(111)
plt.xlim([0, 4])
plt.plot(xd, zd)
plt.show()

Et = 1/fd * np.sum(zd**2);
Pt = Et/dt;
print(Et)
X = fft(zd,N);

Ew = 1/(fd*N) * np.sum(abs(X)**2);
print(Ew)
print(Pt)

zd = A0+A*np.sin(2*np.pi*f0*xd)
af = abs(fft(zd)/N);

plt.figure()
plt.xlim([-50, 50])
plt.plot(xd, fftshift(af))
plt.show()

#f=np.linspace(0, fd/N, fd / (fd-fd/N))
ef = 1/(N*fd) * (np.abs(fft(zd))**2)
plt.plot(xd, fftshift(ef))
plt.show()

pf = ef / dt
plt.plot(xd, fftshift(pf))
plt.show()


f, Pxx_den = periodogram(xd, fd ** (0.5), scaling='spectrum')
plt.ylim([10 ** (-6), 100])
plt.xlim([0, 10])
plt.semilogy(f, Pxx_den)
plt.show()


f, Pxx_den = periodogram(xd, fd, scaling='density')
plt.ylim([10 ** (-6), 100])
plt.xlim([0, 10])
plt.semilogy(f, Pxx_den)
plt.show()




