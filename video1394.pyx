#
#
#
#
#
#
#
#



import threading
import sys

from dc1394 cimport *

import codebench.events as events

import numpy as np
cimport numpy as np

import select


cdef dict color_coding = {
                           DC1394_COLOR_CODING_MONO8      : "MONO8",
                           DC1394_COLOR_CODING_YUV411     : "YUV411",
                           DC1394_COLOR_CODING_YUV422     : "YUV422",
                           DC1394_COLOR_CODING_YUV444     : "YUV444",
                           DC1394_COLOR_CODING_RGB8       : "RGB8",
                           DC1394_COLOR_CODING_MONO16     : "MONO16",
                           DC1394_COLOR_CODING_RGB16      : "RGB16",
                           DC1394_COLOR_CODING_MONO16S    : "MONO16S",
                           DC1394_COLOR_CODING_RGB16S     : "RGB16S",
                           DC1394_COLOR_CODING_RAW8       : "RAW8",
                           DC1394_COLOR_CODING_RAW16      : "RAW16" }


COLOR_CODING_MONO8      = DC1394_COLOR_CODING_MONO8
COLOR_CODING_YUV411     = DC1394_COLOR_CODING_YUV411
COLOR_CODING_YUV422     = DC1394_COLOR_CODING_YUV422
COLOR_CODING_YUV444     = DC1394_COLOR_CODING_YUV444
COLOR_CODING_RGB8       = DC1394_COLOR_CODING_RGB8
COLOR_CODING_MONO16     = DC1394_COLOR_CODING_MONO16
COLOR_CODING_RGB16      = DC1394_COLOR_CODING_RGB16
COLOR_CODING_MONO16S    = DC1394_COLOR_CODING_MONO16S
COLOR_CODING_RGB16S     = DC1394_COLOR_CODING_RGB16S
COLOR_CODING_RAW8       = DC1394_COLOR_CODING_RAW8
COLOR_CODING_RAW16      = DC1394_COLOR_CODING_RAW16

VIDEO_MODE_1600x1200_RGB8       = DC1394_VIDEO_MODE_1600x1200_RGB8
VIDEO_MODE_1280x960_RGB8        = DC1394_VIDEO_MODE_1280x960_RGB8
VIDEO_MODE_1024x768_RGB8        = DC1394_VIDEO_MODE_1024x768_RGB8
VIDEO_MODE_800x600_RGB8         = DC1394_VIDEO_MODE_800x600_RGB8
VIDEO_MODE_640x480_RGB8         = DC1394_VIDEO_MODE_640x480_RGB8
VIDEO_MODE_1600x1200_YUV422     = DC1394_VIDEO_MODE_1600x1200_YUV422
VIDEO_MODE_1280x960_YUV422      = DC1394_VIDEO_MODE_1280x960_YUV422
VIDEO_MODE_1024x768_YUV422      = DC1394_VIDEO_MODE_1024x768_YUV422
VIDEO_MODE_800x600_YUV422       = DC1394_VIDEO_MODE_800x600_YUV422
VIDEO_MODE_640x480_YUV422       = DC1394_VIDEO_MODE_640x480_YUV422
VIDEO_MODE_640x480_YUV411       = DC1394_VIDEO_MODE_640x480_YUV411
VIDEO_MODE_1280x960_MONO8       = DC1394_VIDEO_MODE_1280x960_MONO8
VIDEO_MODE_1024x768_MONO8       = DC1394_VIDEO_MODE_1024x768_MONO8
VIDEO_MODE_800x600_MONO8        = DC1394_VIDEO_MODE_800x600_MONO8
VIDEO_MODE_640x480_MONO8        = DC1394_VIDEO_MODE_640x480_MONO8
VIDEO_MODE_1600x1200_MONO16     = DC1394_VIDEO_MODE_1600x1200_MONO16
VIDEO_MODE_1280x960_MONO16      = DC1394_VIDEO_MODE_1280x960_MONO16
VIDEO_MODE_1600x1200_MONO8      = DC1394_VIDEO_MODE_1600x1200_MONO8
VIDEO_MODE_1024x768_MONO16      = DC1394_VIDEO_MODE_1024x768_MONO16
VIDEO_MODE_800x600_MONO16       = DC1394_VIDEO_MODE_800x600_MONO16
VIDEO_MODE_640x480_MONO16       = DC1394_VIDEO_MODE_640x480_MONO16
VIDEO_MODE_EXIF                 = DC1394_VIDEO_MODE_EXIF
VIDEO_MODE_FORMAT7_0            = DC1394_VIDEO_MODE_FORMAT7_0
VIDEO_MODE_FORMAT7_1            = DC1394_VIDEO_MODE_FORMAT7_1
VIDEO_MODE_FORMAT7_2            = DC1394_VIDEO_MODE_FORMAT7_2
VIDEO_MODE_FORMAT7_3            = DC1394_VIDEO_MODE_FORMAT7_3
VIDEO_MODE_FORMAT7_4            = DC1394_VIDEO_MODE_FORMAT7_4
VIDEO_MODE_FORMAT7_5            = DC1394_VIDEO_MODE_FORMAT7_5
VIDEO_MODE_FORMAT7_6            = DC1394_VIDEO_MODE_FORMAT7_6
VIDEO_MODE_FORMAT7_7            = DC1394_VIDEO_MODE_FORMAT7_7


FRAMERATE_1_875     = DC1394_FRAMERATE_1_875
FRAMERATE_3_75      = DC1394_FRAMERATE_3_75
FRAMERATE_7_5       = DC1394_FRAMERATE_7_5
FRAMERATE_15        = DC1394_FRAMERATE_15
FRAMERATE_30        = DC1394_FRAMERATE_30
FRAMERATE_60        = DC1394_FRAMERATE_60
FRAMERATE_120       = DC1394_FRAMERATE_120
FRAMERATE_240       = DC1394_FRAMERATE_240

ISO_SPEED_800    = DC1394_ISO_SPEED_800
ISO_SPEED_400    = DC1394_ISO_SPEED_400

OPERATION_MODE_1394B    = DC1394_OPERATION_MODE_1394B
OPERATION_MODE_LEGACY   = DC1394_OPERATION_MODE_LEGACY


cdef list DC1394ISOSpeedTable = [
                        DC1394_ISO_SPEED_100,
                        DC1394_ISO_SPEED_200,
                        DC1394_ISO_SPEED_400,
                        DC1394_ISO_SPEED_800,
                        DC1394_ISO_SPEED_1600,
                        DC1394_ISO_SPEED_3200 ]


cdef dict DC1394NumpyColorCoding = {
                        DC1394_COLOR_CODING_MONO8       : (1, np.uint8()),
                        DC1394_COLOR_CODING_YUV411      : (1, np.uint8()),
                        DC1394_COLOR_CODING_YUV422      : (1, np.uint8()),
                        DC1394_COLOR_CODING_YUV444      : (1, np.uint8()),
                        DC1394_COLOR_CODING_RGB8        : (3, np.uint8()),
                        DC1394_COLOR_CODING_MONO16      : (1, np.uint16()),
                        DC1394_COLOR_CODING_RGB16       : (3, np.uint16()),
                        DC1394_COLOR_CODING_MONO16S     : (1, np.int16()),
                        DC1394_COLOR_CODING_RGB16S      : (3, np.int16()),
                        DC1394_COLOR_CODING_RAW8        : (1, np.uint8()),
                        DC1394_COLOR_CODING_RAW16       : (1, np.uint16()),
}

cdef dict DC1394NumpyColorCoding2 = {
            DC1394_COLOR_CODING_MONO8       : ("u8", 1),
            DC1394_COLOR_CODING_YUV411      : ("u8", 1),
            DC1394_COLOR_CODING_YUV422      : ("u8", 1),
            DC1394_COLOR_CODING_YUV444      : ("u8", 1),
            DC1394_COLOR_CODING_RGB8        : ("u8", 3),
            DC1394_COLOR_CODING_MONO16      : ("u16", 1),
            DC1394_COLOR_CODING_RGB16       : ("u16", 3),
            DC1394_COLOR_CODING_MONO16S     : ("i16", 1),
            DC1394_COLOR_CODING_RGB16S      : ("i16", 3),
            DC1394_COLOR_CODING_RAW8        : ("u8", 1),
            DC1394_COLOR_CODING_RAW16       : ("u16", 1),
}



class DC1394Error(Exception): pass


cdef inline int DC1394SafeCall(dc1394error_t error) except -1:
    cdef const_char_ptr errstr
    cdef int return_value = 0
    if DC1394_SUCCESS != error:
        errstr = dc1394_error_get_string(error)
        raise DC1394Error(errstr)
    return return_value


cdef inline dict __dc1394_array_interface__(dc1394video_frame_t *frame):
    cdef str dtype
    cdef uint8_t nbytes
    (dtype, nbytes) = DC1394NumpyColorCoding2[frame.color_coding]
    cdef str endianess = ">%s" % dtype
    if (frame.little_endian == DC1394_TRUE):
        endianess = "%s%s" % ("<", dtype)


    return dict(data = <np.intp_t>frame.image,
                shape = (frame.size[1], frame.size[0], nbytes),
                strides = (frame.stride, nbytes, 1),
                version = 3,
                typestr = endianess)

cdef class FrameObject(object):
    def __init__(self,interface):
        self.__array_interface__ = interface


cdef class DC1394Context(object):
    """
    This object represent a DC1394 context which is needed for further calling
    of dc1394 function
    """
    cdef dc1394_t *dc1394

    def __cinit__(self):
        self.dc1394 = dc1394_new()

    def __dealloc__(self):
        dc1394_free(self.dc1394)

    def __get_number_of_devices__(self):
        cdef dc1394camera_list_t *camera_list
        DC1394SafeCall(dc1394_camera_enumerate(self.dc1394, &camera_list))
        return_value = camera_list.num
        dc1394_camera_free_list(camera_list)
        return return_value

    numberOfDevices = property(__get_number_of_devices__)


    cpdef list enumerateCameras(self):
        cdef dc1394camera_list_t *camera_lst
        cdef list return_value

        DC1394SafeCall(dc1394_camera_enumerate(self.dc1394, &camera_lst))
        return_value = [camera_lst.ids[i] for i in xrange(camera_lst.num)]
        dc1394_camera_free_list(camera_lst)
        return return_value

    cpdef createCamera(self, unsigned int cid):
        cdef dict camdesc = self.enumerateCameras()[cid]
        return  DC1394CameraThread(self, camdesc['guid'], unit = camdesc['unit'])


cdef class DC1394Camera(object):
    cdef dc1394camera_t *cam
    cdef DC1394Context ctx
    cdef dict available_modes
    cdef dict available_features
    cdef dict unavailable_features
    cdef dict available_modes7
    cdef bint stop_event



    def __dealloc__(self):
        dc1394_camera_free(self.cam)

    def set1394B(self):
        self.operationMode = DC1394_OPERATION_MODE_1394B
        self.isoSpeed = DC1394_ISO_SPEED_800

    def set1394A(self):
        self.operationMode = DC1394_OPERATION_MODE_LEGACY
        self.isoSpeed = DC1394_ISO_SPEED_400

    def __cinit__(self, DC1394Context ctx, uint64_t guid, int unit = -1):
        self.ctx = ctx
        if unit != -1:
            self.cam = dc1394_camera_new_unit(ctx.dc1394, guid, unit)
        else:
            self.cam = dc1394_camera_new(ctx.dc1394, guid);
        self.power = False
        self.transmission = DC1394_OFF
        self.populate_capabilities()

    def setdown(self):
        self.stop_event = True;

    def setFormat7(self, int num, tuple size, int coding):
        cdef dc1394video_mode_t mode = <dc1394video_mode_t>num
        cdef dc1394color_coding_t color = <dc1394color_coding_t>coding
        DC1394SafeCall(dc1394_format7_set_image_size(self.cam, mode, size[0], size[1]))
        DC1394SafeCall(dc1394_format7_set_image_position(self.cam, mode, 0, 0))
        DC1394SafeCall(dc1394_format7_set_color_coding(self.cam, mode, color))
        cdef uint32_t packet_size
        self.mode = mode
        DC1394SafeCall(dc1394_format7_get_recommended_packet_size(self.cam, mode, &packet_size))
        print "Packet Size", packet_size
        DC1394SafeCall(dc1394_format7_get_packet_size(self.cam, mode, &packet_size))
        print "Packet Size", packet_size


    def setup(self, unsigned int nbuffers = 10):
        print ("Starting camera...")
        self.power = True
        if self.transmission is DC1394_ON:
            raise RuntimeError("Camera Already Running")
        self.stop_event = False

        DC1394SafeCall(dc1394_capture_setup(self.cam, nbuffers, DC1394_CAPTURE_FLAGS_DEFAULT))
        self.transmission = DC1394_ON
        cdef dc1394video_frame_t *frame

        cdef dc1394video_mode_t current_mode = self.mode
        cdef dc1394color_coding_t color_coding
        DC1394SafeCall(dc1394_get_color_coding_from_video_mode(self.cam, current_mode, &color_coding))
        depth, dtype = DC1394NumpyColorCoding[color_coding]

        cdef unsigned int width, height
        DC1394SafeCall(dc1394_get_image_size_from_video_mode(self.cam, current_mode, &width, &height))

        cdef np.ndarray arr = np.ndarray(shape=(1,1,depth) , dtype=dtype )
        cdef char *orig_ptr = arr.data

        arr.shape[0] = height
        arr.shape[1] = width

        selectlist = [self.fileno]
        try:
            while not self.stop_event:
                rlist, wlist, xlist = select.select(selectlist, [], [], 1)
                if len(rlist) == 0:
                    continue
                dc1394_capture_dequeue(self.cam, DC1394_CAPTURE_POLICY_POLL, &frame)

                arr.data = <char *>frame.image
                arr.strides[0] = frame.stride
                yield arr, frame.timestamp
                dc1394_capture_enqueue(self.cam, frame)
        except:
            pass
        finally:
            arr.data = orig_ptr

            self.transmission = DC1394_OFF
            dc1394_capture_stop(self.cam)
            self.power = False
            print ("Stopping Camera")

    cdef void populate_capabilities(self):
        cdef dc1394video_modes_t modes
        cdef dc1394framerates_t framerates
        cdef float framerate

        self.available_features = {}
        self.unavailable_features = {}
        self.available_modes = {}
        self.available_modes7 = {}

        DC1394SafeCall(dc1394_video_get_supported_modes(self.cam, &modes))
        for m in [modes.modes[i] for i in xrange(modes.num)]:
            try:
                DC1394SafeCall(dc1394_video_get_supported_framerates (self.cam, m, &framerates))
                self.available_modes[m] = [framerates.framerates[j] for j in xrange(framerates.num)]
            except:
                pass


        cdef unsigned int h_size, v_size
        cdef float interval
        cdef dc1394format7mode_t info
        for m in range(DC1394_VIDEO_MODE_FORMAT7_0, DC1394_VIDEO_MODE_FORMAT7_7):
            try:
                DC1394SafeCall(dc1394_format7_get_mode_info(self.cam, m, &info))
                print info.present, info.size_x, info.max_size_x, info.size_y,info.max_size_y, info.total_bytes
                for i in xrange(info.color_codings.num):
                    print color_coding[info.color_codings.codings[i]]
            except:
                pass


        cdef dc1394featureset_t featureset
        DC1394SafeCall(dc1394_feature_get_all(self.cam, &featureset))

        cdef dc1394feature_info_t featureinfo
        for i from 0 < i < DC1394_FEATURE_NUM:
            featureinfo = featureset.feature[i]
            if (featureinfo.available == DC1394_TRUE):
                self.available_features[featureinfo.id] = featureinfo

    property initEvent:
        def __get__(self):
            return self.__init_event__

    property stopEvent:
        def __get__(self):
            return self.__stop_event__


    property fileno:
        def __get__(self):
            return dc1394_capture_get_fileno(self.cam)

    # -------------------------------------------------------------------------

    def __repr__(self):
        return '<DC1394Camera vendor="%s" model="%s"/>' % (self.cam.vendor, self.cam.model)

    # -------------------------------------------------------------------------

    property bandwitdh:
        def __get__(self):
            cdef uint32_t bandwidth
            DC1394SafeCall(dc1394_video_get_bandwidth_usage(self.cam, &bandwidth))
            return bandwidth

    # -------------------------------------------------------------------------

    property multishot:
        def __get__(self):
            cdef dc1394bool_t pwr
            cdef uint32_t frames
            DC1394SafeCall(dc1394_video_get_multi_shot(self.cam, &pwr, &frames))
            return frames if (pwr == DC1394_TRUE) else 0

        def __set__(self, uint32_t frames):
            cdef dc1394bool_t pwr = DC1394_TRUE if (frames > 0) else DC1394_FALSE
            DC1394SafeCall(dc1394_video_set_multi_shot(self.cam, frames, pwr))

    # -------------------------------------------------------------------------
    property brightness:
        def __get__(self):
            if DC1394_FEATURE_BRIGHTNESS not in self.available_features:
                raise DC1394Error("[brightness] not available")

            feature = self.available_features[DC1394_FEATURE_BRIGHTNESS]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_BRIGHTNESS, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_BRIGHTNESS not in self.available_features:
                raise DC1394Error("[brightness not available")

            feature = self.available_features[DC1394_FEATURE_BRIGHTNESS]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[brightness] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[brightness] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_BRIGHTNESS, value))


    # -------------------------------------------------------------------------
    property exposure:
        def __get__(self):
            if DC1394_FEATURE_EXPOSURE not in self.available_features:
                raise DC1394Error("[exposure] not available")

            feature = self.available_features[DC1394_FEATURE_EXPOSURE]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_EXPOSURE, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_EXPOSURE not in self.available_features:
                raise DC1394Error("[exposure not available")

            feature = self.available_features[DC1394_FEATURE_EXPOSURE]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[exposure] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[exposure] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_EXPOSURE, value))


    # -------------------------------------------------------------------------
    property sharpness:
        def __get__(self):
            if DC1394_FEATURE_SHARPNESS not in self.available_features:
                raise DC1394Error("[sharpness] not available")

            feature = self.available_features[DC1394_FEATURE_SHARPNESS]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_SHARPNESS, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_SHARPNESS not in self.available_features:
                raise DC1394Error("[sharpness not available")

            feature = self.available_features[DC1394_FEATURE_SHARPNESS]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[sharpness] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[sharpness] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_SHARPNESS, value))


    # -------------------------------------------------------------------------
    property whiteBalance:
        def __get__(self):
            if DC1394_FEATURE_WHITE_BALANCE not in self.available_features:
                raise DC1394Error("[whiteBalance] not available")

            feature = self.available_features[DC1394_FEATURE_WHITE_BALANCE]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_WHITE_BALANCE, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_WHITE_BALANCE not in self.available_features:
                raise DC1394Error("[whiteBalance not available")

            feature = self.available_features[DC1394_FEATURE_WHITE_BALANCE]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[whiteBalance] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[whiteBalance] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_WHITE_BALANCE, value))


    # -------------------------------------------------------------------------
    property hue:
        def __get__(self):
            if DC1394_FEATURE_HUE not in self.available_features:
                raise DC1394Error("[hue] not available")

            feature = self.available_features[DC1394_FEATURE_HUE]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_HUE, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_HUE not in self.available_features:
                raise DC1394Error("[hue not available")

            feature = self.available_features[DC1394_FEATURE_HUE]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[hue] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[hue] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_HUE, value))


    # -------------------------------------------------------------------------
    property saturation:
        def __get__(self):
            if DC1394_FEATURE_SATURATION not in self.available_features:
                raise DC1394Error("[saturation] not available")

            feature = self.available_features[DC1394_FEATURE_SATURATION]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_SATURATION, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_SATURATION not in self.available_features:
                raise DC1394Error("[saturation not available")

            feature = self.available_features[DC1394_FEATURE_SATURATION]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[saturation] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[saturation] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_SATURATION, value))


    # -------------------------------------------------------------------------
    property gamma:
        def __get__(self):
            if DC1394_FEATURE_GAMMA not in self.available_features:
                raise DC1394Error("[gamma] not available")

            feature = self.available_features[DC1394_FEATURE_GAMMA]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_GAMMA, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_GAMMA not in self.available_features:
                raise DC1394Error("[gamma not available")

            feature = self.available_features[DC1394_FEATURE_GAMMA]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[gamma] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[gamma] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_GAMMA, value))


    # -------------------------------------------------------------------------
    property shutter:
        def __get__(self):
            if DC1394_FEATURE_SHUTTER not in self.available_features:
                raise DC1394Error("[shutter] not available")

            feature = self.available_features[DC1394_FEATURE_SHUTTER]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_SHUTTER, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_SHUTTER not in self.available_features:
                raise DC1394Error("[shutter not available")

            feature = self.available_features[DC1394_FEATURE_SHUTTER]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[shutter] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[shutter] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_SHUTTER, value))


    # -------------------------------------------------------------------------
    property gain:
        def __get__(self):
            if DC1394_FEATURE_GAIN not in self.available_features:
                raise DC1394Error("[gain] not available")

            feature = self.available_features[DC1394_FEATURE_GAIN]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_GAIN, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_GAIN not in self.available_features:
                raise DC1394Error("[gain not available")

            feature = self.available_features[DC1394_FEATURE_GAIN]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[gain] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[gain] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_GAIN, value))


    # -------------------------------------------------------------------------
    property iris:
        def __get__(self):
            if DC1394_FEATURE_IRIS not in self.available_features:
                raise DC1394Error("[iris] not available")

            feature = self.available_features[DC1394_FEATURE_IRIS]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_IRIS, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_IRIS not in self.available_features:
                raise DC1394Error("[iris not available")

            feature = self.available_features[DC1394_FEATURE_IRIS]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[iris] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[iris] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_IRIS, value))


    # -------------------------------------------------------------------------
    property focus:
        def __get__(self):
            if DC1394_FEATURE_FOCUS not in self.available_features:
                raise DC1394Error("[focus] not available")

            feature = self.available_features[DC1394_FEATURE_FOCUS]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_FOCUS, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_FOCUS not in self.available_features:
                raise DC1394Error("[focus not available")

            feature = self.available_features[DC1394_FEATURE_FOCUS]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[focus] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[focus] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_FOCUS, value))


    # -------------------------------------------------------------------------
    property temperature:
        def __get__(self):
            if DC1394_FEATURE_TEMPERATURE not in self.available_features:
                raise DC1394Error("[temperature] not available")

            feature = self.available_features[DC1394_FEATURE_TEMPERATURE]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_TEMPERATURE, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_TEMPERATURE not in self.available_features:
                raise DC1394Error("[temperature not available")

            feature = self.available_features[DC1394_FEATURE_TEMPERATURE]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[temperature] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[temperature] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_TEMPERATURE, value))


    # -------------------------------------------------------------------------
    property trigger:
        def __get__(self):
            if DC1394_FEATURE_TRIGGER not in self.available_features:
                raise DC1394Error("[trigger] not available")

            feature = self.available_features[DC1394_FEATURE_TRIGGER]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_TRIGGER, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_TRIGGER not in self.available_features:
                raise DC1394Error("[trigger not available")

            feature = self.available_features[DC1394_FEATURE_TRIGGER]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[trigger] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[trigger] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_TRIGGER, value))


    # -------------------------------------------------------------------------
    property triggerDelay:
        def __get__(self):
            if DC1394_FEATURE_TRIGGER_DELAY not in self.available_features:
                raise DC1394Error("[triggerDelay] not available")

            feature = self.available_features[DC1394_FEATURE_TRIGGER_DELAY]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_TRIGGER_DELAY, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_TRIGGER_DELAY not in self.available_features:
                raise DC1394Error("[triggerDelay not available")

            feature = self.available_features[DC1394_FEATURE_TRIGGER_DELAY]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[triggerDelay] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[triggerDelay] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_TRIGGER_DELAY, value))


    # -------------------------------------------------------------------------
    property whiteShading:
        def __get__(self):
            if DC1394_FEATURE_WHITE_SHADING not in self.available_features:
                raise DC1394Error("[whiteShading] not available")

            feature = self.available_features[DC1394_FEATURE_WHITE_SHADING]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_WHITE_SHADING, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_WHITE_SHADING not in self.available_features:
                raise DC1394Error("[whiteShading not available")

            feature = self.available_features[DC1394_FEATURE_WHITE_SHADING]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[whiteShading] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[whiteShading] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_WHITE_SHADING, value))


    # -------------------------------------------------------------------------
    property frameRate:
        def __get__(self):
            if DC1394_FEATURE_FRAME_RATE not in self.available_features:
                raise DC1394Error("[frameRate] not available")

            feature = self.available_features[DC1394_FEATURE_FRAME_RATE]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_FRAME_RATE, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_FRAME_RATE not in self.available_features:
                raise DC1394Error("[frameRate not available")

            feature = self.available_features[DC1394_FEATURE_FRAME_RATE]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[frameRate] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[frameRate] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_FRAME_RATE, value))


    # -------------------------------------------------------------------------
    property zoom:
        def __get__(self):
            if DC1394_FEATURE_ZOOM not in self.available_features:
                raise DC1394Error("[zoom] not available")

            feature = self.available_features[DC1394_FEATURE_ZOOM]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_ZOOM, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_ZOOM not in self.available_features:
                raise DC1394Error("[zoom not available")

            feature = self.available_features[DC1394_FEATURE_ZOOM]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[zoom] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[zoom] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_ZOOM, value))


    # -------------------------------------------------------------------------
    property pan:
        def __get__(self):
            if DC1394_FEATURE_PAN not in self.available_features:
                raise DC1394Error("[pan] not available")

            feature = self.available_features[DC1394_FEATURE_PAN]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_PAN, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_PAN not in self.available_features:
                raise DC1394Error("[pan not available")

            feature = self.available_features[DC1394_FEATURE_PAN]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[pan] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[pan] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_PAN, value))


    # -------------------------------------------------------------------------
    property tilt:
        def __get__(self):
            if DC1394_FEATURE_TILT not in self.available_features:
                raise DC1394Error("[tilt] not available")

            feature = self.available_features[DC1394_FEATURE_TILT]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_TILT, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_TILT not in self.available_features:
                raise DC1394Error("[tilt not available")

            feature = self.available_features[DC1394_FEATURE_TILT]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[tilt] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[tilt] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_TILT, value))


    # -------------------------------------------------------------------------
    property opticalFilter:
        def __get__(self):
            if DC1394_FEATURE_OPTICAL_FILTER not in self.available_features:
                raise DC1394Error("[opticalFilter] not available")

            feature = self.available_features[DC1394_FEATURE_OPTICAL_FILTER]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_OPTICAL_FILTER, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_OPTICAL_FILTER not in self.available_features:
                raise DC1394Error("[opticalFilter not available")

            feature = self.available_features[DC1394_FEATURE_OPTICAL_FILTER]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[opticalFilter] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[opticalFilter] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_OPTICAL_FILTER, value))


    # -------------------------------------------------------------------------
    property captureSize:
        def __get__(self):
            if DC1394_FEATURE_CAPTURE_SIZE not in self.available_features:
                raise DC1394Error("[captureSize] not available")

            feature = self.available_features[DC1394_FEATURE_CAPTURE_SIZE]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_CAPTURE_SIZE, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_CAPTURE_SIZE not in self.available_features:
                raise DC1394Error("[captureSize not available")

            feature = self.available_features[DC1394_FEATURE_CAPTURE_SIZE]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[captureSize] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[captureSize] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_CAPTURE_SIZE, value))


    # -------------------------------------------------------------------------
    property captureQuality:
        def __get__(self):
            if DC1394_FEATURE_CAPTURE_QUALITY not in self.available_features:
                raise DC1394Error("[captureQuality] not available")

            feature = self.available_features[DC1394_FEATURE_CAPTURE_QUALITY]
            cdef uint32_t value

            dc1394_feature_get_value(self.cam, DC1394_FEATURE_CAPTURE_QUALITY, &value)
            return value

        def __set__(self, uint32_t value):
            if DC1394_FEATURE_CAPTURE_QUALITY not in self.available_features:
                raise DC1394Error("[captureQuality not available")

            feature = self.available_features[DC1394_FEATURE_CAPTURE_QUALITY]
            if feature['current_mode'] == DC1394_FEATURE_MODE_AUTO:
                raise DC1394Error("[captureQuality] Currently In Auto Mode")

            if value < feature['min'] or value > feature['max']:
                raise DC1394Error("[captureQuality] value out of range")

            DC1394SafeCall(dc1394_feature_set_value(self.cam, DC1394_FEATURE_CAPTURE_QUALITY, value))




    # -------------------------------------------------------------------------

    property oneshot:
        def __get__(self):
            cdef dc1394bool_t pwr
            DC1394SafeCall(dc1394_video_get_one_shot(self.cam, &pwr))
            return (pwr == DC1394_TRUE)

        def __set__(self, bint flag):
            cdef dc1394bool_t pwr = DC1394_TRUE if flag else DC1394_TRUE
            DC1394SafeCall(dc1394_video_set_one_shot(self.cam, pwr))

    # -------------------------------------------------------------------------

    property availableFramerates:
        def __get__(self):
            cdef float framerate
            cdef dict framerates = {}
            for f in self.available_modes[self.mode]:
                dc1394_framerate_as_float(f, &framerate)
                framerates[f] = framerate
            return framerates

    # -------------------------------------------------------------------------

    property availableModes:
        def __get__(self):
            return self.available_modes

    # -------------------------------------------------------------------------

    property mode:
        def __get__(self):
            cdef dc1394video_mode_t mode
            DC1394SafeCall(dc1394_video_get_mode(self.cam, &mode))
            return mode

        def __set__(self, dc1394video_mode_t mode):
            DC1394SafeCall(dc1394_video_set_mode(self.cam, mode))

    # -------------------------------------------------------------------------

    property framerate:
        def __get__(self):
            cdef dc1394framerate_t framerate
            DC1394SafeCall(dc1394_video_get_framerate(self.cam, &framerate))
            return framerate

        def __set__(self, dc1394framerate_t framerate):
            DC1394SafeCall(dc1394_video_set_framerate(self.cam, framerate))

    # -------------------------------------------------------------------------

    property isoSpeed:
        def __get__(self):
            cdef dc1394speed_t speed
            DC1394SafeCall(dc1394_video_get_iso_speed(self.cam, &speed))
            return speed

        def __set__(self, dc1394speed_t speed):
            DC1394SafeCall(dc1394_video_set_iso_speed(self.cam, speed))

    # -------------------------------------------------------------------------

    property operationMode:
        def __get__(self):
            cdef dc1394operation_mode_t mode
            DC1394SafeCall(dc1394_video_get_operation_mode(self.cam, &mode))
            return mode

        def __set__(self, dc1394operation_mode_t mode):
            DC1394SafeCall(dc1394_video_set_operation_mode(self.cam, mode))

    # -------------------------------------------------------------------------

    property transmission:
        def __set__(self, dc1394switch_t trans):
            DC1394SafeCall(dc1394_video_set_transmission(self.cam, trans))

        def __get__(self):
            cdef dc1394switch_t trans
            DC1394SafeCall(dc1394_video_get_transmission(self.cam, &trans))
            return trans

    # -------------------------------------------------------------------------

    property vendor:
        def __get__(self):
            return self.cam.vendor

    # -------------------------------------------------------------------------

    property model:
        def __get__(self):
            return self.cam.model

    # -------------------------------------------------------------------------

    property vendorID:
        def __get__(self):
            return self.cam.vendor_id

    # -------------------------------------------------------------------------

    property modelID:
        def __get__(self):
            return self.cam.model_id

    # -------------------------------------------------------------------------

    property SWVersion:
        def __get__(self):
            return (self.cam.unit_sw_version, self.cam.unit_sub_sw_version)

    # -------------------------------------------------------------------------

    property cycleTimer:
        def __get__(self):
            cdef uint32_t node, generation
            DC1394SafeCall(dc1394_camera_get_node(self.cam, &node, &generation))
            return (node, generation)

    # -------------------------------------------------------------------------

    property node:
        def __get__(self):
            cdef uint32_t cycle_timer
            cdef uint64_t local_time
            DC1394SafeCall(dc1394_read_cycle_timer(self.cam, &cycle_timer, &local_time))
            return (cycle_timer, local_time)

    # -------------------------------------------------------------------------

    property broadcast:
        def __set__(self, bint broadcast):
            cdef dc1394bool_t flag = DC1394_TRUE if broadcast else DC1394_FALSE
            DC1394SafeCall(dc1394_camera_set_broadcast(self.cam, flag))

        def __get__(self):
            cdef dc1394bool_t flag
            DC1394SafeCall(dc1394_camera_get_broadcast(self.cam, &flag))
            return (flag == DC1394_TRUE)

    # -------------------------------------------------------------------------

    property power:
        def __set__(self, bint power):
            cdef dc1394switch_t pwr = DC1394_ON if power else DC1394_OFF
            DC1394SafeCall(dc1394_camera_set_power(self.cam, pwr))

    # -------------------------------------------------------------------------

    property softwareTrigger:
        def __get__(self):
            cdef dc1394switch_t pwr
            DC1394SafeCall(dc1394_software_trigger_get_power(self.cam, &pwr))
            return (pwr == DC1394_ON)

        def __set__(self, bint flag):
            cdef dc1394switch_t pwr = DC1394_ON if flag else DC1394_OFF
            DC1394SafeCall(dc1394_software_trigger_set_power(self.cam, pwr))

    # -------------------------------------------------------------------------



    def print_info(self):
        DC1394SafeCall(dc1394_camera_print_info(self.cam, stderr))
        cdef uint32_t width, height
        cdef dc1394color_coding_t coding
        cdef float framerate
        cdef list props = []
        if self.cam.bmode_capable :
            props.append("bmode")
        if self.cam.one_shot_capable :
            props.append("one_shot")
        if self.cam.multi_shot_capable:
            props.append("multi_shot")
        if self.cam.can_switch_on_off:
            props.append("switch_on_off")
        if self.cam.has_vmode_error_status:
            props.append("vmode_error_status")
        if self.cam.has_feature_error_status:
            props.append("feature_error_status")


        print ("Software Version \t\t  :\tv%d.%d" % self.SWVersion)
        print ("Capabilities \t\t\t  :\t%s" % ", ".join(props))

        print "------ Camera supported modes ------"

        for j, m in enumerate(self.available_modes):
            DC1394SafeCall(dc1394_get_image_size_from_video_mode (self.cam, m, &width, &height))
            DC1394SafeCall(dc1394_get_color_coding_from_video_mode (self.cam, m, &coding))
            framerates = []
            for f in self.available_modes[m]:
                DC1394SafeCall(dc1394_framerate_as_float(f, &framerate))
                framerates.append(framerate)
            print ("%d \t\t\t\t  :\t%dx%d %6s @ %s" % (m, width, height, color_coding[coding], str(framerates)))

        print "------ Camera current mode ------"


        DC1394SafeCall(dc1394_get_image_size_from_video_mode (self.cam, self.mode, &width, &height))
        DC1394SafeCall(dc1394_get_color_coding_from_video_mode (self.cam, self.mode, &coding))
        DC1394SafeCall(dc1394_framerate_as_float(self.framerate, &framerate))
        print "%d \t\t\t\t  :\t%dx%d %s @ %d" % (self.mode, width, height, color_coding[coding], framerate)

        cdef dc1394featureset_t featureset
        DC1394SafeCall(dc1394_feature_get_all(self.cam, &featureset))
        DC1394SafeCall(dc1394_feature_print_all(&featureset, stderr))



    def resetBus(self):
        dc1394_reset_bus(self.cam);

    def resetToFactoryDefault(self):
        dc1394_camera_reset(self.cam)

cdef class DC1394CameraThread(DC1394Camera):
    cdef object __grab_event__
    cdef object __init_event__
    cdef object __stop_event__
    cdef object capture_loop


    def __cinit__(self, DC1394Context ctx, uint64_t guid, int unit = -1):
        self.stop_event = False
        self.__grab_event__ = events.Event()
        self.__init_event__ = events.Event()
        self.__stop_event__ = events.Event()

    def start(self):
        self.capture_loop = threading.Thread(target = self.run, name = "DC1394 capture loop")
        self.capture_loop.start()

    # -------------------------------------------------------------------------

    property grabEvent:
        def __get__(self):
            return self.__grab_event__




    def run(self):
        gen = self.setup()
        for f in self.setup():
            self.__grab_event__(*f)

    def stop(self, join = True):
        self.stop_event = True
        if join:
            self.capture_loop.join()
        self.power = False



#
# vim: filetype=pyrex
#
#
#

