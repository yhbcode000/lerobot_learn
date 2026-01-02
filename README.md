# LeRobot Operation Guide (SO-101)

This document outlines the workflow for setting up hardware, recording data, training models (SmolVLA), and evaluating performance.

## 1. Hardware Calibration & Rule Installation

Navigate to the device-specific directory to install calibration parameters and set up USB `udev` rules.

```bash
# Navigate to the driver directory
cd /media/shirox/Storage/ubuntu_workspace/lerobot_learn/254218-R12255108

# Install calibration parameters
bash install_calib_params.sh

# Install USB port rules
bash install_rules.sh

```

---

## 2. Environment Setup

Prepare the workspace by activating the virtual environment and synchronizing dependencies.

```bash
# Return to the main workspace
cd /media/shirox/Storage/ubuntu_workspace/lerobot_learn

# Sync project dependencies
uv sync

# Activate the virtual environment
source ./.venv/bin/activate
```

---

## 3. Hardware Discovery & Configuration

Before proceeding, identify the correct ports for the arms and the camera.

### Robotic Arms

Run `lerobot-find-port` to verify connections. Based on current setup:

* **White Follower Arm:** `/dev/ttyACM0`
* **Black Leader Arm:** `/dev/ttyACM1`
* **Robot ID:** `R12255108`
* **Teleop (Leader) ID:** `R07255108`

### Cameras

Run `lerobot-find-cameras` to confirm indices.

* **Hand-eye Camera:** Found at `/dev/video4` (640x480 @ 30 FPS).

---

## 4. Teleoperation & Data Recording

Test the hardware connection via teleoperation and record datasets for training.

```bash
# Start teleoperation (Manual control test)
lerobot-teleoperate --config_path configs/so101_teleop.yaml

# Record data for training
lerobot-record --config_path configs/so101_record.yaml

```

---

## 5. Model Training (SmolVLA)

Install the necessary VLA dependencies and initiate the training process.

```bash
# Install SmolVLA extensions
uv add lerobot[smolvla]

# Set Hugging Face mirror for faster downloads (if applicable)
export HF_ENDPOINT=https://hf-mirror.com

# Start a new training session
lerobot-train --config_path configs/smolvla_train.yaml

# Resume training from a specific checkpoint
lerobot-train \
  --config_path=outputs/train/act_so101_grab/checkpoints/last/pretrained_model/train_config.json \
  --resume=true

```

---

## 6. Evaluation & Inference

Clear previous evaluation caches and run the trained policy on the robot.

```bash
# Remove evaluation cache
rm -r /home/shirox/.cache/huggingface/lerobot/yhbcode000/eval_so101

# Run the policy in the real environment
lerobot-record \
  --config_path configs/smolvla_eval.yaml \
  --policy.path=outputs/train/smolvla_grab/checkpoints/last/pretrained_model \
  --policy.device=cuda

```
