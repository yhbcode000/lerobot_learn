# PowerShell script to install SO101 calibration parameters
$CALIB_PARENT_DIR = "$env:USERPROFILE\.cache\huggingface\lerobot"
$CALIB_DIR = "$CALIB_PARENT_DIR\calibration"

Write-Host "Copying calibration files to $CALIB_PARENT_DIR"
Copy-Item -Path "calibration" -Destination $CALIB_PARENT_DIR -Recurse -Force

exit 0