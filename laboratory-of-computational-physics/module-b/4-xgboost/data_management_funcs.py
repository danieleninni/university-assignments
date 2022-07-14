import numpy as np
import matplotlib.pyplot as plt

folder_data = 'DATA'

# note: this function has been edited, it is not the original one
def show_data_strains(x,L,s="data",dim=1,nsegments=3):  # plot_strains
    for k in range(nsegments):
        plt.plot(np.arange(k*L, (k+1)*L),x[k])
    #plt.plot(np.arange(L),x[0])
    #plt.plot(np.arange(L,2*L),x[1])
    #plt.plot(np.arange(2*L,3*L),x[2])
    plt.title(s)
    plt.xlabel("time")
    plt.show()

def pattern(i,z,a):
    return int(a*np.sin((np.pi*i)/z))

def create_strain(N=10000,L=60,DX=50,bias=5,reshape=True):
    jumps = np.random.normal(bias,DX,size=(N*L))
    jumps_int = np.rint(jumps)  # round to int to mimic discrete values from detector
    jumps_int[0] = 0            # set the first element to zero
    x = np.cumsum(jumps_int)    # cumulative sum
    if reshape:
        x = x.reshape((N,L))
    return x

def create_strains_dataset(dim,Z=12,A=500,N=10000,L=60,DX=50,bias=5):
    strains = []
    for i in range(dim):
        strains.append(create_strain(N=N,L=L,DX=DX,bias=bias,reshape=False))
    this = np.dstack(tuple(strains))[0]
    x = this.reshape((N,L,dim))
    y = np.zeros(N)
    for i in range(N):
        y[i] = i%3
        if y[i] > 0:
            max_shift = 4
            j0 = np.random.randint(0,L-1-Z-max_shift*(dim-1))  # base point
            j_steps = np.random.randint(0,max_shift,size=(dim-1))  # other shifts
            if dim > 2:
                j_steps = np.cumsum(j_steps)
            sign = 3-2*y[i]
            patt = np.zeros(Z)
            for j in range(Z):  # generating the pattern, once for all
                patt[j] = sign*pattern(j,Z,A)  # this is not vectorial, so I must use a for loop
            # inject the patterns
            x[i][j0:j0+Z].T[0] += patt
            for count,js in enumerate(j_steps):
                x[i][j0+js:j0+Z+js].T[count+1] += patt
    return x, y

def saver(x,y,dim=2,Z=12,A=500,N=10000,L=60,DX=50,bias=5):
    #!mkdir DATA -p
    str0 = f'ts_L{L}_Z{Z}_A{A}_DX{DX}_bias{bias}_N{N}.dat'
    print('Saving', str0, '...')
    xr = x.reshape((N*L,dim))  # when you read it back, use .reshape((N,L,dim))
    fnamex='DATA/x_'+str0
    np.savetxt(fnamex,xr,fmt="%d")
    fnamey='DATA/y_'+str0
    np.savetxt(fnamey,y,fmt="%d")
    print('Done!\n')
    return

def reader_strains(plot=True,dim=2,Z=12,A=500,N=10000,L=60,DX=50,bias=5):  # reader_strains
    str0 = f'ts_L{L}_Z{Z}_A{A}_DX{DX}_bias{bias}_N{N}.dat'
    print('Reading',str0,'...')
    fnamex = 'DATA/x_'+str0
    fnamey = 'DATA/y_'+str0
    x = np.loadtxt(fnamex,delimiter=" ",dtype=float)
    x = x.reshape((N,L,dim))
    if plot == True:
        Show_data(x,L,"data from file",nsegments=6)
    categ = np.loadtxt(fnamey,dtype=int)
    n_class = 3 # y.argmax()-y.argmin()+1
    y = np.zeros((N,n_class))
    for i in range(N):
        y[i][categ[i]] = 1.
    print('Done!')
    return x,y,n_class

def data_preprocess_strains(x,y,n_class,plot=True,dim=2,Z=12,A=500,N=10000,L=60,DX=50,bias=5):
    # FIRST PASSAGE: DO NOT DO THIS --> FAILURE 
    # remove average value of each sample from its values
    xm = x.mean(axis=1)
    for i in range(N):
        x[i] = x[i]-xm[i]
    # SECOND PASSAGE: DO NOT DO THIS --> ALSO FAILURE 
    # rescale (crude version, variance should be used)
    x = x/400
    if plot == True:    
        Show_data(x,L,"rescaled data",nsegments=6)
    perc_train = 0.8
    N_train = int(perc_train*N)
    x_train = x[:N_train]
    y_train = y[:N_train]
    x_val = x[N_train:]
    y_val = y[N_train:]
    N_val = len(x_val)
    #print(f'A={A}, N_train={N_train}, N_val={N_val}, L={L}, n_class={n_class}')
    #x_train = x_train.astype("float32")
    #y_train = y_train.astype("float32")
    #x_val = x_val.astype("float32")
    #y_val = y_val.astype("float32")
    x_train = x_train.reshape(x_train.shape[0],L,dim)
    x_val =  x_val.reshape(x_val.shape[0],L,dim)
    return x_train,y_train,x_val,y_val

def Show_history(fit, EPOCHS, title):
    fig,AX = plt.subplots(1,2,figsize=(16,5.))
    ax = AX[0]
    ax.plot(fit.history['accuracy'],"b",label="train")
    ax.plot(fit.history['val_accuracy'],"r--",label="valid.")
    ax.plot((0,EPOCHS),(1/3,1/3),":",c="gray",label="random choice")
    ax.set_xlabel('epoch')
    ax.set_ylabel("Accuracy"+title)
    ax.set_ylim([0,1])
    ax.legend()
    ax = AX[1]
    ax.plot(fit.history['loss'],"b",label="train")
    ax.plot(fit.history['val_loss'],"r--",label="valid.")
    ax.set_xlabel('epoch')
    ax.set_ylabel("Loss"+title)
    ax.set_ylim([0,1.05*np.max(fit.history['loss'])])
    ax.legend()
    plt.show()

def show_confusion_matrix(validations,predictions,label="Model"):
    LABELS = ["absent","positive","negative"]
    cmap = "GnBu"
    matrix = metrics.confusion_matrix(validations,predictions)
    plt.figure(figsize=(6,5))
    seaborn.heatmap(matrix,
                    xticklabels=LABELS,
                    yticklabels=LABELS,
                    annot=True,
                    fmt='d',
                    linecolor='white',
                    linewidths=1,
                    cmap=cmap)
    plt.title(label+': Confusion Matrix')
    plt.ylabel('True Label')
    plt.xlabel('Predicted Label')
    plt.show()