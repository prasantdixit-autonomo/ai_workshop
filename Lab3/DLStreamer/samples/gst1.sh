#!/bin/bash

CHANNELS=${1:-1}
DEVICE=${2:-CPU}
INPUT=${3:-store-aisle-detection.mp4}


if [[ $3 == "display" ]] || [[ -z $3 ]]; then
  SINK_ELEMENT="gvawatermark ! videoconvert ! gvafpscounter ! autovideosink sync=false"
elif [[ $3 == "fps" ]]; then
  SINK_ELEMENT="gvafpscounter ! fakesink async=false "
else
  echo Error wrong value for SINK_ELEMENT parameter
  echo Possible values: display - render, fps - show FPS only
  exit
fi

MODEL1=person-detection-retail-0013/FP32/person-detection-retail-0013.xml

if [[ $INPUT == "/dev/video"* ]]; then
  SOURCE_ELEMENT="v4l2src device=${INPUT}"
elif [[ $INPUT == *"://"* ]]; then
  SOURCE_ELEMENT="urisourcebin buffer-size=4096 uri=${INPUT}"
else
  SOURCE_ELEMENT="filesrc location=${INPUT}"
fi


PIPELINE="$SOURCE_ELEMENT ! decodebin ! \
gvadetect model=$MODEL1 device=$DEVICE ! queue ! \
gvawatermark ! videoconvert ! fpsdisplaysink video-sink=xvimagesink sync=false "

echo ${PIPELINE}
#$PIPELINE

FINAL_PIPELINE_STR="gst-launch-1.0 "
for (( CURRENT_CHANNELS_COUNT=0; CURRENT_CHANNELS_COUNT < $CHANNELS; ++CURRENT_CHANNELS_COUNT )); do
	FINAL_PIPELINE_STR+=$PIPELINE
done

echo ${FINAL_PIPELINE_STR}
$FINAL_PIPELINE_STR
