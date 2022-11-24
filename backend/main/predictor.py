import json
import time
import sys
from argparse import ArgumentParser
import tensorflow as tf
import os
import logging
import cv2
from PIL import Image
import numpy as np
import PIL.Image


try:
    os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3' 
    tf.compat.v1.logging.set_verbosity(tf.compat.v1.logging.ERROR)
    dic = {
        0:"Gucci_ophidia",
        1:"Gucci_jackie",
        2:"Gucci_sylvie",
        3:"Gucci_marmont",
        4:"Gucci_bamboo",
        5:"Gucci_diana",
        6:"Gucci_dionysus",
        7:"Gucci_horsebit",
    }

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
    img = img.convert('RGB')
    img = img.resize((128, 128))  # L: greyscale mode   P: color mode
    img = np.array(img).astype(np.float32)

    imgs = np.array([img])
    result = model.predict(imgs, verbose=0)
    scores = result[0]


    score_list = []
    result = []
    for i in range(len(scores)):
        score_list.append((scores[i], i))
    score_list.sort(key=lambda x:-x[0])

    for i in range(len(score_list)):
        # result.append(dic[score_list[i][1]])
        print(json.dumps(dic[score_list[i][1]]))

except Exception as e:
    print(e)

# model.summary()t