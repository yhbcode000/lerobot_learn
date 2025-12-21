#!/bin/bash

CALIB_PARENT_DIR="$HOME/.cache/huggingface/lerobot"
CALIB_DIR="$CALIB_PARENT_DIR/calibration"

echo "Copying calibration files to $CALIB_PARENT_DIR"
cp -r calibration $CALIB_PARENT_DIR/

exit 0
