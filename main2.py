import pygame
pygame.init()

import video1394
import numpy as np
import scipy as sc
import traceback
from pylab import *

import time
import sys


size = width, height = 480, 640
screen = pygame.display.set_mode(size)

i = 0

def test(im, timestamp):
    global i
    sys.stderr.write("grab %d %d \r" % (i, timestamp))
    i += 1
    try:
        py_img = pygame.image.frombuffer(im.T.copy(), im.shape, "RGB")
        screen.blit(py_img, py_img.get_rect())
        pygame.display.flip()
    except (Exception, e):
        print e

ctx = video1394.DC1394Context()
camera = ctx.createCamera(0)
camera.resetBus()
camera.mode = video1394.VIDEO_MODE_640x480_RGB8
camera.framerate = video1394.FRAMERATE_15
camera.print_info()
gen = camera.setup()
import time
def onstop(*args):
    camera.setdown()
    for f in gen:
        print f
    time.sleep(1)

for f in gen:
    test(*f)

import signal
signal.signal(signal.SIGINT, onstop)

