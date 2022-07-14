#    LCP modB, assignment 01
#
# This code snippet plots the Train & Loss trend.

import matplotlib.pyplot as plt
import numpy as np

def plot_train_loss(fit):
    fig, AX = plt.subplots(1, 2, figsize=(14,6.))
    ax = AX[0]
    ax.plot(fit.history['accuracy'], label="train")
    ax.plot(fit.history['val_accuracy'], label="validation")
    ax.set_xlabel('epoch');  ax.set_ylabel("Accuracy")
    ax = AX[1]
    ax.plot(fit.history['loss'], label="train")
    ax.plot(fit.history['val_loss'], label="validation")
    ax.set_xlabel('epoch');  ax.set_ylabel("Loss");  ax.legend()
    return ax

def triangle_boundaries(ax):    
    ax.plot((-20,-20), (-40,50), c="w")
    ax.plot((-20,50), (-40,-40), c="w")
    ax.plot((-10,50), (50,-10), c="w")

def predictions_triangles(x, y, model, rescale):
    # cell 1
    dX = 2
    X1 = np.arange(-50, 50+dX, dX)
    LG = len(X1)
    grid = np.zeros((LG*LG, 2))
    k = 0
    for i in range(LG):
        for j in range(LG):
            grid[k,:] = (X1[j], X1[i])
            k = k+1
    #print(len(X1), len(grid))
    #print(grid[-1])

    # RESCALE
    grid_r = rescale(grid)
    pred = model.predict(grid_r)

    # cell 2
    fig, AX = plt.subplots(1, 3, figsize=(16,5.))
    ax = AX[0]
    ax.scatter(x[:,0], x[:,1], c=y)
    triangle_boundaries(ax)
    ax = AX[1]
    ax.scatter(grid[:,0], grid[:,1], c=pred)
    triangle_boundaries(ax)
    ax = AX[2]
    W1 = np.where(pred > 0.5)[0] 
    ax.scatter(grid[:,0], grid[:,1], c="#440154")
    ax.scatter(grid[W1,0], grid[W1,1], c="#fde725")
    triangle_boundaries(ax)
    #plt.show()
    
    return plt