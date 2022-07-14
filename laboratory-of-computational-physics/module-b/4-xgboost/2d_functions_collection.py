#    LCP modB, exercise 04
#
# This code snippet defines new non-linear functions to test.

import numpy as np
import types
import matplotlib.pyplot as plt

# please define the functions adding **kwargs to args

def triangle(x, **kwargs):
    result = 0
    if x[0] > -20 and x[1] > -40 and x[0]+x[1] < 40:
        result = 1
    return result

def baiesi_second(x, **kwargs):
    result = 0
    if (np.sign(x.sum())*np.sign(x[0]))*np.cos(np.linalg.norm(x)/(2*np.pi)) > 0:
        result = 1
    return result

def N_sphere(x, n):
    result = 0
    if np.sqrt(np.inner(x, x)) < 30:
        result = 1
    return result

def hollow_N_sphere(x, n):
    result = 0
    if (np.sqrt(np.inner(x, x)) > 15) and (np.sqrt(np.inner(x, x)) < 30):
        result = 1
    return result

def multi_sphere(x, n):
    result = 0
    Dx1, Dx2, Dx3, Dx4= 20*np.ones(n), -30*np.ones(n), 40*np.concatenate((np.zeros(1), np.ones(n-1)), axis=0), 25*np.concatenate((np.ones(n-1), -0.5*(np.ones(1))), axis=0)
    if ((np.sqrt(np.inner(x, x)) < 15) or (np.sqrt(np.inner(x+Dx1, x+Dx1)) < 20) or (np.sqrt(np.inner(x+Dx2, x+Dx2)) < 25) or (np.sqrt(np.inner(x+Dx3, x+Dx3)) < 20) or (np.sqrt(np.inner(x+Dx4, x+Dx4)) < 15)):
        result = 1
    return result

def polyhedron(x, n):
    result = 0
    xsum = (np.sum(np.abs(x),axis=0))
    if xsum < 20*n:
        result =1
    return result
    
def hollow_polyhedron(x, n):
    result = 0
    xsum = (np.sum(np.abs(x),axis=0))
    if (xsum > 15*n) and (xsum < 30*n):
        result = 1
    return result

def multi_polyhedron(x, n):
    result = 0
    Dx1, Dx2, Dx3, Dx4= 20*np.ones(n), -30*np.ones(n), 40*np.concatenate((np.zeros(1), np.ones(n-1)), axis=0), 25*np.concatenate((np.ones(n-1), -0.5*(np.ones(1))), axis=0)
    xsum = (np.sum(np.abs(x),axis=0))
    xsum1, xsum2, xsum3, xsum4 = (np.sum(np.abs(x+Dx1),axis=0)), (np.sum(np.abs(x+Dx2),axis=0)), (np.sum(np.abs(x+Dx3),axis=0)), (np.sum(np.abs(x+Dx4),axis=0))
    if (xsum < 15) or (xsum1 < 20) or (xsum2 < 25) or (xsum3 < 20) or (xsum4 < 15):
        result = 1
    return result

def sine_surface(x, n):
    result = 0
    if np.sum((x[1:]),axis=0)/50*n + np.sin(x[0]/5) + 0.5 < 1:
        result = 1
    return result

def chessboard(x, n):
    result = 0
    y = ((x // 25)%2)*2-1
    if np.prod(y, axis=0) < 0:
        result = 1
    return result

def mixed_chessboard(x, n):
    result = 0
    y = ((x // 25)%2)*2-1
    z = 0
    if np.prod(y, axis=0) < 0:
        z = 1
    w = 1
    #x[0] = 0.5*x[0]
    if (np.sqrt(np.inner(x, x)) > 20) and (np.sqrt(np.inner(x, x)) < 40):
        w = 0
    if z != w:
        result = 1
    return result

############################################################
# NOTE: place all the callable functions above this point! #
############################################################

available_functions = [f for f in globals().values() if type(f) == types.FunctionType][1:]  # remove the first one
available_functions_names = [ str(f).split()[1] for f in available_functions ]

def print_available_functions():
    print('--- available functions ---')
    for fn in available_functions_names:
        print(fn)
    print('===========================')

# access to the functions using an int index value
def f2d(index, *args, **kwargs):
    return( available_functions[index](*args, **kwargs) )

def plot_available_functions(N=6000, B=100, **kwargs):
    #  arguments:
    # N - number of samples
    # B - box size (along each dimension) (centered on the origin)
    
    nrows = 6;  ncols = 2;  base_figsize = 3.5
    
    # dimensionality of the box (2 is 2D) (FIXED for this code!)
    n = 2
    # size of each sample (equal to the dimensionality)
    L = n

    x = (np.random.random((N,n))-0.5)*B
    y = np.zeros(N)
    
    if len(available_functions) > nrows*ncols:  print("ERROR: grid is too small to plot all the functions")
    fig, axes = plt.subplots(nrows=nrows, ncols=ncols, figsize=(base_figsize*ncols, base_figsize*nrows))
    
    for i, (f, fn) in enumerate(zip(available_functions, available_functions_names)):        
        ax = axes[ int(i/ncols) , i%ncols]
        for i in range(N):  y[i] = f(x[i], n=2)  # compute the predictions for current function
        ax.scatter(x[:,0], x[:,1], c=y)
        ax.title.set_text(fn)
        ax.axis('off')
    
    for i in range( len(available_functions), nrows*ncols): # remove the empty subplots
        fig.delaxes(axes[ int(i/ncols) , i%ncols])
        
    plt.tight_layout()
    return plt