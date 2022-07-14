import matplotlib.pyplot as plt
import numpy as np

def plot_fit_train_loss(fit):
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