
import os
import numpy as np
import cv2
import tensorflow as tf


def load_malaria_filenames(load_data_dir, labels, tot_images):
    X = []
    Y = []

    for l_idx, label in enumerate(labels):
        image_names = os.listdir(os.path.join(load_data_dir, label))

        for i, image_name in enumerate(image_names[:tot_images]):
            if not image_name.endswith('.png'):
                continue
            img_name = os.path.join(load_data_dir, label, image_name)
            X.append(img_name)
            Y.append(l_idx)

    print('Loading filenames completed.')

    return X, Y


def load_malaria_image(img_name):
    num_row = 100
    num_col = 100

    if isinstance(img_name, bytes):
        img_name = img_name.decode()

    img = cv2.imread(img_name, cv2.IMREAD_COLOR)
    img = np.array(cv2.resize(img, (num_row, num_col)), dtype='float32')

    return img


def normalize_img(image):
    return tf.cast(image, tf.float32) / 255.
