
from libc.stdint cimport *

cdef extern from *:
    ctypedef char* const_char_ptr "const char*"
    ctypedef struct FILE
    cdef FILE *stderr


cdef extern from "dc1394/dc1394.h":
    ctypedef enum dc1394error_t:
        DC1394_SUCCESS
        DC1394_FAILURE
        DC1394_NOT_A_CAMERA
        DC1394_FUNCTION_NOT_SUPPORTED
        DC1394_CAMERA_NOT_INITIALIZED
        DC1394_MEMORY_ALLOCATION_FAILURE
        DC1394_TAGGED_REGISTER_NOT_FOUND
        DC1394_NO_ISO_CHANNEL
        DC1394_NO_BANDWIDTH
        DC1394_IOCTL_FAILURE
        DC1394_CAPTURE_IS_NOT_SET
        DC1394_CAPTURE_IS_RUNNING
        DC1394_RAW1394_FAILURE
        DC1394_FORMAT7_ERROR_FLAG_1
        DC1394_FORMAT7_ERROR_FLAG_2
        DC1394_INVALID_ARGUMENT_VALUE
        DC1394_REQ_VALUE_OUTSIDE_RANGE
        DC1394_INVALID_FEATURE
        DC1394_INVALID_VIDEO_FORMAT
        DC1394_INVALID_VIDEO_MODE
        DC1394_INVALID_FRAMERATE
        DC1394_INVALID_TRIGGER_MODE
        DC1394_INVALID_TRIGGER_SOURCE
        DC1394_INVALID_ISO_SPEED
        DC1394_INVALID_IIDC_VERSION
        DC1394_INVALID_COLOR_CODING
        DC1394_INVALID_COLOR_FILTER
        DC1394_INVALID_CAPTURE_POLICY
        DC1394_INVALID_ERROR_CODE
        DC1394_INVALID_BAYER_METHOD
        DC1394_INVALID_VIDEO1394_DEVICE
        DC1394_INVALID_OPERATION_MODE
        DC1394_INVALID_TRIGGER_POLARITY
        DC1394_INVALID_FEATURE_MODE
        DC1394_INVALID_LOG_TYPE
        DC1394_INVALID_BYTE_ORDER
        DC1394_INVALID_STEREO_METHOD
        DC1394_BASLER_NO_MORE_SFF_CHUNKS
        DC1394_BASLER_CORRUPTED_SFF_CHUNK
        DC1394_BASLER_UNKNOWN_SFF_CHUNK

    ctypedef enum dc1394color_coding_t:
        DC1394_COLOR_CODING_MONO8
        DC1394_COLOR_CODING_YUV411
        DC1394_COLOR_CODING_YUV422
        DC1394_COLOR_CODING_YUV444
        DC1394_COLOR_CODING_RGB8
        DC1394_COLOR_CODING_MONO16
        DC1394_COLOR_CODING_RGB16
        DC1394_COLOR_CODING_MONO16S
        DC1394_COLOR_CODING_RGB16S
        DC1394_COLOR_CODING_RAW8
        DC1394_COLOR_CODING_RAW16

    ctypedef enum dc1394color_filter_t:
        DC1394_COLOR_FILTER_RGGB
        DC1394_COLOR_FILTER_GBRG
        DC1394_COLOR_FILTER_GRBG
        DC1394_COLOR_FILTER_BGGR
        

    ctypedef enum dc1394operation_mode_t:
        DC1394_OPERATION_MODE_LEGACY
        DC1394_OPERATION_MODE_1394B
        DC1394_CAPTURE_FLAGS_DEFAULT
        DC1394_CAPTURE_FLAGS_BANDWIDTH_ALLOC
        DC1394_CAPTURE_FLAGS_CHANNEL_ALLOC
        DC1394_CAPTURE_FLAGS_AUTO_ISO

    ctypedef enum dc1394speed_t:
        DC1394_ISO_SPEED_100
        DC1394_ISO_SPEED_200
        DC1394_ISO_SPEED_400
        DC1394_ISO_SPEED_800
        DC1394_ISO_SPEED_1600
        DC1394_ISO_SPEED_3200

    enum:
        DC1394_VIDEO_MODE_FORMAT7_NUM   "DC1394_VIDEO_MODE_FORMAT7_NUM"
        DC1394_FRAMERATE_NUM            "DC1394_FRAMERATE_NUM"
        DC1394_VIDEO_MODE_NUM           "DC1394_VIDEO_MODE_NUM"
        DC1394_FEATURE_MODE_NUM         "DC1394_FEATURE_MODE_NUM"
        DC1394_TRIGGER_ACTIVE_NUM       "DC1394_TRIGGER_ACTIVE_NUM"
        DC1394_TRIGGER_MODE_NUM         "DC1394_TRIGGER_MODE_NUM"
        DC1394_FEATURE_NUM              "DC1394_FEATURE_NUM"
        DC1394_TRIGGER_SOURCE_NUM       "DC1394_TRIGGER_SOURCE_NUM"
        DC1394_COLOR_CODING_NUM         "DC1394_COLOR_CODING_NUM"

    ctypedef enum dc1394video_mode_t:
        DC1394_VIDEO_MODE_160x120_YUV444
        DC1394_VIDEO_MODE_320x240_YUV422
        DC1394_VIDEO_MODE_640x480_YUV411
        DC1394_VIDEO_MODE_640x480_YUV422
        DC1394_VIDEO_MODE_640x480_RGB8
        DC1394_VIDEO_MODE_640x480_MONO8
        DC1394_VIDEO_MODE_640x480_MONO16
        DC1394_VIDEO_MODE_800x600_YUV422
        DC1394_VIDEO_MODE_800x600_RGB8
        DC1394_VIDEO_MODE_800x600_MONO8
        DC1394_VIDEO_MODE_1024x768_YUV422
        DC1394_VIDEO_MODE_1024x768_RGB8
        DC1394_VIDEO_MODE_1024x768_MONO8
        DC1394_VIDEO_MODE_800x600_MONO16
        DC1394_VIDEO_MODE_1024x768_MONO16
        DC1394_VIDEO_MODE_1280x960_YUV422
        DC1394_VIDEO_MODE_1280x960_RGB8
        DC1394_VIDEO_MODE_1280x960_MONO8
        DC1394_VIDEO_MODE_1600x1200_YUV422
        DC1394_VIDEO_MODE_1600x1200_RGB8
        DC1394_VIDEO_MODE_1600x1200_MONO8
        DC1394_VIDEO_MODE_1280x960_MONO16
        DC1394_VIDEO_MODE_1600x1200_MONO16
        DC1394_VIDEO_MODE_EXIF
        DC1394_VIDEO_MODE_FORMAT7_0
        DC1394_VIDEO_MODE_FORMAT7_1
        DC1394_VIDEO_MODE_FORMAT7_2
        DC1394_VIDEO_MODE_FORMAT7_3
        DC1394_VIDEO_MODE_FORMAT7_4
        DC1394_VIDEO_MODE_FORMAT7_5
        DC1394_VIDEO_MODE_FORMAT7_6
        DC1394_VIDEO_MODE_FORMAT7_7

    ctypedef struct dc1394video_modes_t:
        uint32_t                num
        dc1394video_mode_t      modes[DC1394_VIDEO_MODE_NUM]

    ctypedef enum dc1394color_coding_t:
        DC1394_COLOR_CODING_MONO8
        DC1394_COLOR_CODING_YUV411
        DC1394_COLOR_CODING_YUV422
        DC1394_COLOR_CODING_YUV444
        DC1394_COLOR_CODING_RGB8
        DC1394_COLOR_CODING_MONO16
        DC1394_COLOR_CODING_RGB16
        DC1394_COLOR_CODING_MONO16S
        DC1394_COLOR_CODING_RGB16S
        DC1394_COLOR_CODING_RAW8
        DC1394_COLOR_CODING_RAW16

    ctypedef enum dc1394color_filter_t:
        DC1394_COLOR_FILTER_RGGB
        DC1394_COLOR_FILTER_GBRG
        DC1394_COLOR_FILTER_GRBG
        DC1394_COLOR_FILTER_BGGR

    ctypedef enum dc1394byte_order_t:
        DC1394_BYTE_ORDER_UYVY
        DC1394_BYTE_ORDER_YUYV


    ctypedef enum dc1394bool_t:
        DC1394_FALSE
        DC1394_TRUE

    ctypedef enum dc1394switch_t:
        DC1394_OFF
        DC1394_ON

    ctypedef enum dc1394capture_policy_t:
        DC1394_CAPTURE_POLICY_WAIT
        DC1394_CAPTURE_POLICY_POLL


    ctypedef enum dc1394framerate_t:
        DC1394_FRAMERATE_1_875
        DC1394_FRAMERATE_3_75
        DC1394_FRAMERATE_7_5
        DC1394_FRAMERATE_15
        DC1394_FRAMERATE_30
        DC1394_FRAMERATE_60
        DC1394_FRAMERATE_120
        DC1394_FRAMERATE_240


    ctypedef enum dc1394iidc_version_t:
        DC1394_IIDC_VERSION_1_04
        DC1394_IIDC_VERSION_1_20
        DC1394_IIDC_VERSION_PTGREY
        DC1394_IIDC_VERSION_1_30
        DC1394_IIDC_VERSION_1_31
        DC1394_IIDC_VERSION_1_32
        DC1394_IIDC_VERSION_1_33
        DC1394_IIDC_VERSION_1_34
        DC1394_IIDC_VERSION_1_35
        DC1394_IIDC_VERSION_1_36
        DC1394_IIDC_VERSION_1_37
        DC1394_IIDC_VERSION_1_38
        DC1394_IIDC_VERSION_1_39

    ctypedef struct dc1394_t:
        pass

    ctypedef struct dc1394camera_id_t:
        uint16_t             unit
        uint64_t             guid

    ctypedef struct dc1394camera_list_t:
        uint32_t             num
        dc1394camera_id_t    *ids

    ctypedef enum dc1394feature_t:
        DC1394_FEATURE_BRIGHTNESS
        DC1394_FEATURE_EXPOSURE
        DC1394_FEATURE_SHARPNESS
        DC1394_FEATURE_WHITE_BALANCE
        DC1394_FEATURE_HUE
        DC1394_FEATURE_SATURATION
        DC1394_FEATURE_GAMMA
        DC1394_FEATURE_SHUTTER
        DC1394_FEATURE_GAIN
        DC1394_FEATURE_IRIS
        DC1394_FEATURE_FOCUS
        DC1394_FEATURE_TEMPERATURE
        DC1394_FEATURE_TRIGGER
        DC1394_FEATURE_TRIGGER_DELAY
        DC1394_FEATURE_WHITE_SHADING
        DC1394_FEATURE_FRAME_RATE
        DC1394_FEATURE_ZOOM
        DC1394_FEATURE_PAN
        DC1394_FEATURE_TILT
        DC1394_FEATURE_OPTICAL_FILTER
        DC1394_FEATURE_CAPTURE_SIZE
        DC1394_FEATURE_CAPTURE_QUALITY

    ctypedef enum dc1394feature_mode_t:
        DC1394_FEATURE_MODE_MANUAL
        DC1394_FEATURE_MODE_AUTO
        DC1394_FEATURE_MODE_ONE_PUSH_AUTO

    ctypedef enum dc1394trigger_polarity_t:
        DC1394_TRIGGER_ACTIVE_LOW
        DC1394_TRIGGER_ACTIVE_HIGH

    ctypedef enum dc1394trigger_source_t:
        DC1394_TRIGGER_SOURCE_0
        DC1394_TRIGGER_SOURCE_1
        DC1394_TRIGGER_SOURCE_2
        DC1394_TRIGGER_SOURCE_3
        DC1394_TRIGGER_SOURCE_SOFTWARE

    ctypedef enum dc1394trigger_mode_t:
        DC1394_TRIGGER_MODE_0
        DC1394_TRIGGER_MODE_1
        DC1394_TRIGGER_MODE_2
        DC1394_TRIGGER_MODE_3
        DC1394_TRIGGER_MODE_4
        DC1394_TRIGGER_MODE_5
        DC1394_TRIGGER_MODE_14
        DC1394_TRIGGER_MODE_15

    ctypedef struct dc1394trigger_sources_t:
        uint32_t                num[DC1394_TRIGGER_SOURCE_NUM]
        dc1394trigger_source_t  sources


    ctypedef struct dc1394feature_modes_t:
        uint32_t                num[DC1394_FEATURE_MODE_NUM]
        dc1394feature_mode_t    modes

    ctypedef struct dc1394trigger_modes_t:
        uint32_t                num[DC1394_TRIGGER_MODE_NUM]
        dc1394trigger_mode_t    modes

    ctypedef struct dc1394feature_info_t:
        dc1394feature_t             id
        dc1394bool_t                available
        dc1394bool_t                absolute_capable
        dc1394bool_t                readout_capable
        dc1394bool_t                on_off_capable
        dc1394bool_t                polarity_capable
        dc1394switch_t              is_on

        dc1394feature_mode_t        current_mode
        dc1394trigger_mode_t        trigger_mode
        dc1394trigger_polarity_t    trigger_polarity
        dc1394trigger_source_t      trigger_source

        uint32_t                    min
        uint32_t                    max
        uint32_t                    value
        uint32_t                    BU_value
        uint32_t                    RV_value
        uint32_t                    B_value
        uint32_t                    R_value
        uint32_t                    G_value
        uint32_t                    target_value

        dc1394switch_t              abs_control
        float                       abs_value
        float                       abs_max
        float                       abs_min


    ctypedef struct dc1394featureset_t:
        dc1394feature_info_t    feature[DC1394_FEATURE_NUM]

    ctypedef struct dc1394camera_t :
        uint64_t             guid
        int                  unit
        uint32_t             unit_spec_ID
        uint32_t             unit_sw_version
        uint32_t             unit_sub_sw_version
        uint32_t             command_registers_base
        uint32_t             unit_directory
        uint32_t             unit_dependent_directory
        uint64_t             advanced_features_csr
        uint64_t             PIO_control_csr
        uint64_t             SIO_control_csr
        uint64_t             strobe_control_csr
        uint64_t             format7_csr[DC1394_VIDEO_MODE_FORMAT7_NUM]
        dc1394iidc_version_t iidc_version
        char               * vendor
        char               * model
        uint32_t             vendor_id
        uint32_t             model_id
        dc1394bool_t         bmode_capable
        dc1394bool_t         one_shot_capable
        dc1394bool_t         multi_shot_capable
        dc1394bool_t         can_switch_on_off
        dc1394bool_t         has_vmode_error_status
        dc1394bool_t         has_feature_error_status
        int                  max_mem_channel
        uint32_t             flags

    ctypedef struct dc1394video_frame_t:
        unsigned char          * image
        uint32_t                 size[2]
        uint32_t                 position[2]
        dc1394color_coding_t     color_coding
        dc1394color_filter_t     color_filter
        uint32_t                 yuv_byte_order
        uint32_t                 data_depth
        uint32_t                 stride
        dc1394video_mode_t       video_mode
        uint64_t                 total_bytes
        uint32_t                 image_bytes
        uint32_t                 padding_bytes
        uint32_t                 packet_size
        uint32_t                 packets_per_frame
        uint64_t                 timestamp
        uint32_t                 frames_behind
        dc1394camera_t           *camera
        uint32_t                 id
        uint64_t                 allocated_image_bytes
        dc1394bool_t             little_endian
        dc1394bool_t             data_in_padding

    ctypedef struct dc1394framerates_t:
        uint32_t                num
        dc1394framerate_t       framerates[DC1394_FRAMERATE_NUM]

    ctypedef struct dc1394color_codings_t:
        uint32_t                num
        dc1394color_coding_t    codings[DC1394_COLOR_CODING_NUM]

    ctypedef struct dc1394format7mode_t:
        dc1394bool_t            present
        uint32_t                size_x
        uint32_t                size_y
        uint32_t                max_size_x
        uint32_t                max_size_y
        uint32_t                pos_x
        uint32_t                pos_y
        uint32_t                unit_size_x
        uint32_t                unit_size_y
        uint32_t                unit_pos_x
        uint32_t                unit_pos_y
        dc1394color_codings_t   color_codings
        dc1394color_coding_t    color_coding
        uint32_t                pixnum
        uint32_t                packet_size
        uint32_t                unit_packet_size
        uint32_t                max_packet_size
        uint64_t                total_bytes
        dc1394color_filter_t    color_filter


    dc1394_t* dc1394_new () nogil
    void dc1394_free(dc1394_t *) nogil

    dc1394error_t dc1394_camera_enumerate(dc1394_t *, dc1394camera_list_t **) nogil
    void dc1394_camera_free_list(dc1394camera_list_t *) nogil

    # -------------------------------------------------------------------------

    dc1394camera_t *dc1394_camera_new(dc1394_t *, uint64_t) nogil
    dc1394camera_t * dc1394_camera_new_unit(dc1394_t *dc1394, uint64_t, int)
    void dc1394_camera_free(dc1394camera_t *) nogil
    dc1394error_t dc1394_reset_bus(dc1394camera_t *) nogil

    # -------------------------------------------------------------------------

    dc1394error_t dc1394_video_get_operation_mode(dc1394camera_t *, dc1394operation_mode_t *) nogil
    dc1394error_t dc1394_video_set_operation_mode(dc1394camera_t *, dc1394operation_mode_t) nogil

    dc1394error_t dc1394_video_set_iso_speed(dc1394camera_t *, dc1394speed_t) nogil
    dc1394error_t dc1394_video_get_iso_speed(dc1394camera_t *, dc1394speed_t *) nogil

    dc1394error_t dc1394_video_set_mode(dc1394camera_t *, dc1394video_mode_t) nogil
    dc1394error_t dc1394_video_get_mode(dc1394camera_t *, dc1394video_mode_t *) nogil

    dc1394error_t dc1394_video_get_framerate(dc1394camera_t *, dc1394framerate_t *) nogil
    dc1394error_t dc1394_video_set_framerate(dc1394camera_t *, dc1394framerate_t) nogil

    dc1394error_t dc1394_video_get_supported_modes(dc1394camera_t *camera, dc1394video_modes_t *video_modes) nogil
    dc1394error_t dc1394_video_get_supported_framerates(dc1394camera_t *camera, dc1394video_mode_t video_mode, dc1394framerates_t *framerates) nogil

    dc1394error_t dc1394_get_image_size_from_video_mode(dc1394camera_t *camera, dc1394video_mode_t video_mode, uint32_t *width, uint32_t *height) nogil
    dc1394error_t dc1394_get_color_coding_from_video_mode(dc1394camera_t *camera, dc1394video_mode_t video_mode, dc1394color_coding_t *color_coding) nogil

    dc1394error_t dc1394_framerate_as_float(dc1394framerate_t framerate_enum, float *framerate) nogil

    const_char_ptr dc1394_error_get_string(dc1394error_t error) nogil

    dc1394error_t dc1394_capture_setup(dc1394camera_t *, uint32_t, uint32_t) nogil
    dc1394error_t dc1394_capture_stop(dc1394camera_t *) nogil

    dc1394error_t dc1394_video_set_transmission(dc1394camera_t *, dc1394switch_t) nogil
    dc1394error_t dc1394_video_get_transmission(dc1394camera_t *, dc1394switch_t*) nogil

    dc1394error_t dc1394_capture_dequeue(dc1394camera_t *, dc1394capture_policy_t, dc1394video_frame_t **frame) nogil
    dc1394error_t dc1394_capture_enqueue(dc1394camera_t *, dc1394video_frame_t *) nogil


    dc1394error_t dc1394_camera_print_info(dc1394camera_t *, FILE *) nogil
    dc1394error_t dc1394_feature_print_all(dc1394featureset_t *, FILE *) nogil

    dc1394error_t dc1394_camera_get_node(dc1394camera_t *, uint32_t *, uint32_t *) nogil
    dc1394error_t dc1394_read_cycle_timer (dc1394camera_t * camera, uint32_t *, uint64_t *)

    dc1394error_t dc1394_camera_get_broadcast(dc1394camera_t *, dc1394bool_t *) nogil
    dc1394error_t dc1394_camera_set_broadcast(dc1394camera_t *, dc1394bool_t) nogil

    int dc1394_capture_get_fileno (dc1394camera_t * camera) nogil

    dc1394bool_t dc1394_capture_is_frame_corrupt (dc1394camera_t *, dc1394video_frame_t *) nogil

    dc1394error_t dc1394_camera_reset(dc1394camera_t *) nogil
    dc1394error_t dc1394_camera_set_power(dc1394camera_t *camera, dc1394switch_t pwr) nogil

    dc1394error_t dc1394_software_trigger_get_power(dc1394camera_t *, dc1394switch_t *) nogil
    dc1394error_t dc1394_software_trigger_set_power(dc1394camera_t *, dc1394switch_t) nogil

    dc1394error_t dc1394_video_get_bandwidth_usage(dc1394camera_t *, uint32_t *) nogil

    dc1394error_t dc1394_video_get_multi_shot(dc1394camera_t *camera, dc1394bool_t *, uint32_t *) nogil
    dc1394error_t dc1394_video_set_multi_shot(dc1394camera_t *camera, uint32_t, dc1394bool_t) nogil

    dc1394error_t dc1394_video_get_one_shot(dc1394camera_t *, dc1394bool_t *) nogil
    dc1394error_t dc1394_video_set_one_shot(dc1394camera_t *, dc1394bool_t)

    dc1394error_t dc1394_feature_print_all(dc1394featureset_t *, FILE *) nogil
    dc1394error_t dc1394_feature_get_all(dc1394camera_t *, dc1394featureset_t *) nogil


    dc1394error_t dc1394_feature_get_value(dc1394camera_t *, dc1394feature_t, uint32_t *) nogil
    dc1394error_t dc1394_feature_set_value(dc1394camera_t *, dc1394feature_t, uint32_t) nogil

    dc1394error_t dc1394_format7_get_max_image_size(dc1394camera_t *, dc1394video_mode_t, uint32_t *, uint32_t *) nogil
    dc1394error_t dc1394_format7_get_unit_size(dc1394camera_t *, dc1394video_mode_t, uint32_t *, uint32_t *) nogil
    dc1394error_t dc1394_format7_get_image_size(dc1394camera_t *, dc1394video_mode_t, uint32_t *, uint32_t *) nogil
    dc1394error_t dc1394_format7_set_image_size(dc1394camera_t *, dc1394video_mode_t, uint32_t, uint32_t) nogil
    dc1394error_t dc1394_format7_get_image_position(dc1394camera_t *, dc1394video_mode_t, uint32_t *, uint32_t *) nogil
    dc1394error_t dc1394_format7_set_image_position(dc1394camera_t *, dc1394video_mode_t, uint32_t, uint32_t) nogil
    dc1394error_t dc1394_format7_get_unit_position(dc1394camera_t *, dc1394video_mode_t, uint32_t *, uint32_t *) nogil
    dc1394error_t dc1394_format7_get_frame_interval(dc1394camera_t *, dc1394video_mode_t, float *) nogil
    dc1394error_t dc1394_format7_get_total_bytes(dc1394camera_t *, dc1394video_mode_t, uint64_t *) nogil
    dc1394error_t dc1394_format7_get_pixel_number(dc1394camera_t *, dc1394video_mode_t, uint32_t *) nogil
    dc1394error_t dc1394_format7_set_roi(dc1394camera_t *, dc1394video_mode_t, int, int, int, int, int) nogil
    dc1394error_t dc1394_format7_get_roi(dc1394camera_t *, dc1394video_mode_t, int *, int *, int *, int *, int *) nogil
    dc1394error_t dc1394_format7_set_color_coding(dc1394camera_t *, dc1394video_mode_t, dc1394color_coding_t) nogil
    dc1394error_t dc1394_format7_get_recommended_packet_size(dc1394camera_t *, dc1394video_mode_t, uint32_t *) nogil
    dc1394error_t dc1394_format7_set_packet_size(dc1394camera_t *, dc1394video_mode_t, uint32_t) nogil
    dc1394error_t dc1394_format7_get_packet_size(dc1394camera_t *, dc1394video_mode_t, uint32_t *) nogil

    dc1394error_t dc1394_format7_get_mode_info(dc1394camera_t *, dc1394video_mode_t, dc1394format7mode_t *info) nogil
