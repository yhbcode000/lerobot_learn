Windows系统，在Powershell下执行 .\install_calib_params.ps1
For Windows system, execute .\install_calib_params.ps1 in PowerShell.

Ubuntu系统，在终端中执行以下命令安装标定参数
For Ubuntu system, run the following command in the terminal to install the calibration parameters:
bash install_calib_params.sh

执行以下命令安装映射规则
Execute the following command to install the mapping rules:
bash install_rules.sh

然后 follower 臂的设备文件端口号为"/dev/so101_follower"，leader 臂的设备文件端口号为"/dev/so101_leader"。
Then, the device file port for the follower arm is "/dev/so101_follower", and for the leader arm is "/dev/so101_leader".

后续自行组双臂时，请修改 install_rules.sh 中的端口，添加 "_left" 或 "_right" 后缀，例如："/dev/so101_follower_left", "/dev/so101_leader_right"
When setting up dual arms independently later, please modify the ports in install_rules.sh by adding the "_left" or "_right" suffix, for example: "/dev/so101_follower_left", "/dev/so101_leader_right".