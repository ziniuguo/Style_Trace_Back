import time
import sys
from argparse import ArgumentParser
import tensorflow as tf
import os
import logging
import cv2
from PIL import Image
import numpy as np

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3' 
tf.compat.v1.logging.set_verbosity(tf.compat.v1.logging.ERROR)


parser = ArgumentParser()
parser.add_argument("-f", "--file", dest="filename",
                    help="write report to FILE", metavar="FILE")
parser.add_argument("-q", "--quiet",
                    action="store_false", dest="verbose", default=True,
                    help="don't print status messages to stdout")

args = parser.parse_args()
file_path = args.filename
model = tf.keras.models.load_model('model/model.h5')

img = Image.open(f"data/{file_path}")
img = img.resize((128, 128))  # L: greyscale mode   P: color mode
img = np.array(img).astype(np.float32)

imgs = np.array([img])
result = model.predict(imgs, verbose=0)
scores = result[0]

index = 0
max_score = 0
for i in range(len(scores)):
    if max_score < scores[i]:
        max_score = scores[i]
        index = i
print(index)

# model.summary()t