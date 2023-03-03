import numpy as np
import os
import pandas as pd
from matplotlib.gridspec import GridSpec
from ecgdetectors import Detectors
from scipy.signal import resample

DATA_FILE_PATH = "data/REMOCOP_20211022_17h20.csv" 

# DECODING FUNCTIONS
def convert_array_to_signed_int(data, offset, length):
    return int.from_bytes(
        bytearray(data[offset: offset + length]), byteorder="little", signed=True,
    )


def convert_to_unsigned_long(data, offset, length):
    return int.from_bytes(
        bytearray(data[offset: offset + length]), byteorder="little", signed=False,
    )


def data_conv2(data):
    ecg_session_data = []
    ecg_session_time = []
    if len(data)>0:
        tmp = data[0]
    else:
        tmp = 0x00

    if tmp == 0x00:
        timestamp = convert_to_unsigned_long(data, 1, 8)
        step = 3
        samples = data[10:]
        offset = 0
        while offset < len(samples):
            ecg = convert_array_to_signed_int(samples, offset, step)
            offset += step
            ecg_session_data.extend([ecg])
            ecg_session_time.extend([timestamp])
    return ecg_session_data

# MAIN FUNCTION
def load_dataset():

    # Load data
    data_df = pd.read_csv(DATA_FILE_PATH, sep='\t')

    ppg_df = data_df["PPGvalue"].dropna()
    ppg_signal = np.array(ppg_df).reshape(-1,1)

    # This step is necessary because the file contains less ECG packets than PPG
    ecg_df = data_df["ECGString"].dropna()
    
    ecg_signal = []
    for sample in ecg_df:
        array_data = bytearray()
        vec = np.arange(0, len(sample), 2)

        for index in vec:
            tmp = sample[index:index + 2]
            tmp2 = int(tmp, 16)
            array_data.append(int(tmp2))
        ecg_track = data_conv2(array_data)
    
        ecg_signal.extend(ecg_track)
    
    ecg_signal = np.array(ecg_signal).reshape(-1,1)

    return ppg_signal, ecg_signal

# ECG segmentation
def segment_ECG(ecg_signal, fs = 130, word_len = 100):
    detectors = Detectors(fs)
    r_peaks = detectors.two_average_detector(np.squeeze(ecg_signal))
    ecg_matrix = []
    original_len = []
    for i in range(len(r_peaks)-1):
        ecg_segment = np.array((ecg_signal[r_peaks[i]:r_peaks[i+1]]).reshape(1,-1)[0])
        original_len.append(len(ecg_segment))
        ecg_word = resample(ecg_segment, 100)
        ecg_matrix.append(ecg_word)

    ecg_matrix = np.array(ecg_matrix)
    return ecg_matrix, r_peaks, original_len


# Signal reconstruction
def matrix_to_signal(matrix, original_len = None):
    if original_len == None:
        signal = matrix.reshape(-1,1,order = 'C')
    else:  
        signal = []
        for i in range(len(original_len)):
            ecg_word = resample(matrix[-len(original_len)+i,:], original_len[-len(original_len)+i])
            signal.extend(ecg_word)
        signal = np.array(signal)
    return signal
