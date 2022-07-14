import numpy as np
import matplotlib.pyplot as plt

# note: this function has been edited, it is not the original one
def Show_data(x,L,s="data",dim=1,nsegments=3):
    for k in range(nsegments):
        plt.plot(np.arange(k*L, (k+1)*L),x[k])
    #plt.plot(np.arange(L),x[0])
    #plt.plot(np.arange(L,2*L),x[1])
    #plt.plot(np.arange(2*L,3*L),x[2])
    plt.title(s)
    plt.xlabel("time")
    plt.show()