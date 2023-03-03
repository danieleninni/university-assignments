
import os
import pandas as pd
import h5py


def load_data():
    """
    Loads PCam dataset.
        
    Returns:    
    Tuple: `(x_train, y_train, meta_train), (x_test, y_test, meta_test)`.
    """

    x_train = h5py.File(os.path.join('pcamv1', 'camelyonpatch_level_2_split_train_x_cut.h5'), 'r')['x']
    y_train = h5py.File(os.path.join('pcamv1', 'camelyonpatch_level_2_split_train_y_cut.h5'), 'r')['y']
    x_test = h5py.File(os.path.join('pcamv1', 'camelyonpatch_level_2_split_test_x_cut.h5'), 'r')['x']
    y_test = h5py.File(os.path.join('pcamv1', 'camelyonpatch_level_2_split_test_y_cut.h5'), 'r')['y']
    
    meta_train = pd.read_csv(os.path.join('pcamv1', 'camelyonpatch_level_2_split_train_meta_cut.csv'))
    meta_test = pd.read_csv(os.path.join('pcamv1', 'camelyonpatch_level_2_split_test_meta_cut.csv'))

    return (x_train, y_train, meta_train), (x_test, y_test, meta_test)
