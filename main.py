import cv2
import cv

import video1394
import numpy as np
import scipy as sc
import traceback
from pylab import *

import time
import sys


window = cvw.namedWindow("Meh")

def test(im, timestamp):
    global i
    sys.stderr.write("grab %d %d \r" % (i, timestamp))
    try:
        cvim = cv.fromarray(im)
        cv2.imshow(cvim)
        cv2.waitKey(0)
    except (Exception, e):
        print e

ctx = video1394.DC1394Context()
camera = ctx.createCamera(0)
camera.resetBus()
camera.set1394A()
camera.mode = video1394.VIDEO_MODE_640x480_MONO8
camera.framerate = video1394.FRAMERATE_15
camera.print_info()
camera.grabEvent.addObserver(test)
camera.start()

import gobject
import signal
gobject.threads_init()
loop = gobject.MainLoop()
def onstop(*args):
    loop.quit()

signal.signal(signal.SIGINT, onstop)
loop.run()
print "Stopping Camera"
camera.stop()

