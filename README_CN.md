## 📚 **官方文档与代码源**
### ✅ 核心文档来源
- **Feishu 补充文档（v0.3）**：[LeRobot SO-101机械臂使用文档-v0.3](https://tcnppips4y7o.feishu.cn/wiki/FPlmwRDW1i2fdAkJqj1c5zbDnzb)  
  - 强调舵机严禁长时间堵转、闪红灯需立刻断电；
  - 推荐使用 JoyandAI/lerobot 仓库（与文档同步）；
  - 使用 `pip install -e ".[feetech]"` 安装舵机驱动；
  - 推荐 ffmpeg 7.1.1（支持 libsvtav1）。

- **Hugging Face 官方 SO-101 指南**：[huggingface.co/docs/lerobot/so101](https://huggingface.co/docs/lerobot/so101)  
  - 完整硬件 BOM 表、装配步骤（按 Joint 1~6 逐项说明）；
  - 提供 `find_port.py`、`setup_motors`、`calibrate` 三阶段配置流程；
  - Leader/Follower 分别校准，命名唯一。

- **代码仓库**
  - **官方主仓库**：[huggingface/lerobot](https://github.com/huggingface/lerobot)  
    - 支持 ACT / Diffusion / TDMPC 等策略；
    - 提供 `lerobot-dataset-viz`、`lerobot-train` 等 CLI 工具。
  - **同步版推荐仓库**：[JoyandAI/lerobot](https://github.com/JoyandAI/lerobot)  
    - 与 Feishu 教程一致性高，适合初学者。

- **硬件设计**：[TheRobotStudio/SO-ARM100](https://github.com/TheRobotStudio/SO-ARM100)  
  - 提供完整 STL 文件（含单文件合集与分件）；
  - 推荐打印参数：PLA+，15% infill，0.2mm layer；
  - 支持多种扩展配件（抬高底座、AnySkin 触觉、多种摄像头支架）；
  - 电机配置表清晰（Leader：1/191、1/345、1/147；Follower：全部 1/345）。

---

## 🎥 **Bilibili 视频资源整理**
- [**BV18gG1z4EZu**](https://m.bilibili.com/video/BV18gG1z4EZu?share_source=weixin_web&vd_source=ee47bc205ad83b3065c4fb3b342720a9)：《LeRobot训练SO-101机械臂ACT模型全流程解析》  
  内容涵盖：硬件深度解析 → 电机/控制器调优 → 轻量化部署 → 产线兼容模拟 。

- [**BV1CNNoeeEpJ**](https://m.bilibili.com/video/BV1CNNoeeEpJ?share_source=weixin_web&vd_source=ee47bc205ad83b3065c4fb3b342720a9)：《【全球首发】LeRobot SO-ARM101 具身智能机械臂 - 组装和配置教程》  
  由 WowRobo 提供，含实操入门课程（含软件环境配置）。

- [**BV14kA2erEkR**](https://m.bilibili.com/video/BV14kA2erEkR?share_source=weixin_web&vd_source=ee47bc205ad83b3065c4fb3b342720a9)：《Lerobot SO-ARM101 新品机械臂组装教程（CAD 动画）》  
  动态可视化组装流程，辅助理解机械结构 。

---

## 🧪 **端到端开发流程总结（整合多源）**
1. **环境配置**
   - Python 3.10 + Miniconda；
   - 安装 LeRobot + Feetech 驱动；
   - 确认 ffmpeg 7.1.1（`conda install -c conda-forge ffmpeg=7.1.1`）。

2. **硬件组装与通电**
   - 严格按 Joint 1~6 顺序安装（参考 Hugging Face 表格）；
   - Leader 用 5V/7.4V 舵机，Follower 可选 12V（需匹配电源）；
   - **严禁堵转或夹持硬物**（Feishu 警告）。

3. **电机 ID 与波特率配置**
   - 先 `python lerobot/find_port.py` 获取端口；
   - 分别对 Leader/Follower 运行 `setup_motors`，按提示逐个连接舵机；
   - ID 分配：gripper=6, wrist_roll=5, ..., shoulder_pan=1。

4. **校准（Calibration）**
   - 将机械臂置于中位，运行 `lerobot.calibrate`；
   - 手动全行程旋转每个关节；
   - 保存唯一 `--robot.id`（如 `my_follower_v1`）。

5. **数据采集与训练**
   - 使用 `koch` 风格脚本采集演示数据；
   - 支持 ACT、Diffusion、SmolVLA 等策略微调 ；
   - Jetson Orin Nano / K1 开发板亦可部署 。

6. **推理与可视化**
   - `lerobot.replay.py` 运行策略；
   - 使用 `lerobot-dataset-viz` 查看数据集；
   - 可接入 Foxglove 实现 ROS2 可视化 。
