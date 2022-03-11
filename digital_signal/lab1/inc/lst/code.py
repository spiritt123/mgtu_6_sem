import matplotlib.pyplot as plt
import numpy as np

def f(t):
    return (np.exp(-t) * np.cos(2*np.pi*t) + 1)


b = 17
A = 1
N=2^b
q=2*A/(N-1) 

def quantum(t):
    buffer = (np.exp(-t) * np.cos(2*np.pi*t) + 1)
    
    for i in range(buffer.size):
        out = 0
        while buffer[i] > q:
            out += q
            buffer[i] = buffer[i] - q
        buffer[i] = out
    return buffer


fd = 0.5

start = 0.0
stop   = 5.0

t1 = np.arange(start, stop, fd)
t2 = np.arange(start, stop, fd / 100000)

plt.figure()
plt.subplot(212)
plt.plot(t2, f(t2), 'k')


plt.figure()
plt.subplot(212)
plt.plot(t1, f(t1), 'bo', t2, f(t2), 'k')

plt.figure()
plt.subplot(212)
plt.plot(t1, f(t1), 'bo', t1, quantum(t1), 'k')

plt.figure()
plt.subplot(212)
plt.plot(t2, f(t2), 'k', t1, f(t1), 'bo', t1, quantum(t1), 'k')

plt.figure()
plt.subplot(212)
plt.plot(t1, f(t1) - quantum(t1), 'bo', t1, f(t1) - quantum(t1), 'k')


x = np.arange(start, stop)
y = f(t1) - quantum(t1)

fig, ax = plt.subplots()

ax.bar(t1, f(t1) - quantum(t1))

ax.set_facecolor('seashell')
fig.set_facecolor('floralwhite')
fig.set_figwidth(12)    #  ширина Figure
fig.set_figheight(6)    #  высота Figure


plt.show()
