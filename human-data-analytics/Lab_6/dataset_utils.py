
import tensorflow as tf
import tensorflow_text as tf_text
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker


def load_data(path, buff_size):
    text = path.read_text(encoding='utf-8')

    lines = text.splitlines()[:buff_size]
    pairs = [line.split('\t') for line in lines]

    inp = [inp for _, inp, _ in pairs]
    targ = [targ for targ, _, _ in pairs]

    return inp, targ


def tf_lower_and_split_punct(text):
    # Split accented characters
    text = tf_text.normalize_utf8(text, 'NFKD')
    text = tf.strings.lower(text)
    # Keep space, a to z, and select punctuation
    text = tf.strings.regex_replace(text, '[^ a-z.?!,\']', '')
    # Add spaces around punctuation
    text = tf.strings.regex_replace(text, '[.?!,\']', r' \0 ')
    # Strip whitespace
    text = tf.strings.strip(text)

    text = tf.strings.join(['[START]', text, '[END]'], separator=' ')
    return text


def plot_attention(attention, sentence, predicted_sentence):
        sentence = tf_lower_and_split_punct(sentence).numpy().decode().split()
        predicted_sentence = predicted_sentence.numpy().decode().split() + ['[END]']
        fig = plt.figure(figsize=(10, 10))
        ax = fig.add_subplot(1, 1, 1)

        attention = attention[:len(predicted_sentence), :len(sentence)]

        ax.matshow(attention, cmap='viridis', vmin=0.0)

        fontdict = {'fontsize': 14}

        ax.set_xticklabels([''] + sentence, fontdict=fontdict, rotation=90)
        ax.set_yticklabels([''] + predicted_sentence, fontdict=fontdict)

        ax.xaxis.set_major_locator(ticker.MultipleLocator(1))
        ax.yaxis.set_major_locator(ticker.MultipleLocator(1))

        ax.set_xlabel('Input text')
        ax.set_ylabel('Output text')
        plt.suptitle('Attention weights')

