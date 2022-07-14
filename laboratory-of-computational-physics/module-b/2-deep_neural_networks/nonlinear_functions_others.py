#    LCP modB, assignment 01
#
# This code snippet defines new non-linear functions to test.

import numpy as np
import types

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
def f_index(index, *args, **kwargs):
    return( available_functions[index](*args, **kwargs) )

# old function
def f_old(x, c, n = 2):
    if c == 1:
        r = triangle(x)
    if c == 2:
        r = baiesi_second(x)
    if c == 3:
        r = N_sphere(x, n)
    if c == 4:
        r = hollow_N_sphere(x, n)
    if c == 5:
        r = multi_sphere(x, n)
    if c == 6:
        r = polyhedron(x, n)
    if c == 7:
        r = hollow_polyhedron(x, n)
    if c == 8:
        r = multi_polyhedron(x, n)
    if c == 9:
        r = sine_surface(x, n)
    if c == 10:
        r = chessboard(x, n)
    if c == 11:
        r = mixed_chessboard(x, n)
    return r

def filename(s, TYPE, n):
    return "./DATA/"+s+"-for-DNN-"+str(TYPE)+"type-"+str(n)+"n-dim"+".dat"