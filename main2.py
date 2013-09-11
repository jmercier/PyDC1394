import cv, cv2

import video1394
import numpy as np
import scipy as sc
import traceback
from pylab import *

import time
import sys

cv2.namedWindow("Meh")
cv2.namedWindow("Meh2")

i = 0
def test(im, timestamp):
    global i
    sys.stderr.write("grab %d %d \r" % (i, timestamp))
    cv2.imshow("Meh", im )
    cv2.waitKey(1)

def test2(im, timestamp):
    global i
    sys.stderr.write("grab %d %d \r" % (i, timestamp))
    cv2.imshow("Meh2", im )
    cv2.waitKey(1)

def testc(event, posx, posy, flag, self):
    print event, posx, posy, flag, self
    pass

cv2.setMouseCallback("Meh", testc)

ctx = video1394.DC1394Context()
cameras = []
gens = []
for i in range(1,2):
    camera = ctx.createCamera(i)
    camera.resetBus()
    camera.set1394A()
    camera.mode = video1394.VIDEO_MODE_640x480_MONO8
    camera.framerate = video1394.FRAMERATE_60
    camera.print_info()
    gen = camera.setup()
    gens.append(gen)
    cameras.append(camera)


import time
def onstop(*args):
    for c in cameras:
        c.setdown()
    time.sleep(1)


import signal
signal.signal(signal.SIGINT, onstop)

while True:
    f1 = next(gens[0])
    test(*f1)


