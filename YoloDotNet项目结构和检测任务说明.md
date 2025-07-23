# YoloDotNet 项目结构和检测任务说明文档

## 项目概述

YoloDotNet 是一个基于 .NET 6.0 的高性能计算机视觉库，专门用于实时目标检测、分割、分类、姿态估计和跟踪。该项目使用 ONNX Runtime 作为推理引擎，支持 CUDA GPU 加速，能够处理图像和视频流。

### 技术特点
- **高性能**: v3.0版本相比之前版本，推理速度提升高达70%，内存使用减少高达92%
- **多模型支持**: 支持 YOLOv5u–v12、YOLO-World、YOLO-E 等多种模型
- **GPU加速**: 支持 CUDA 12.x 和 cuDNN 9.x 加速
- **灵活输入**: 支持 SKBitmap、SKImage、字节数组等多种输入格式
- **实时处理**: 支持视频流、摄像头实时处理

## 项目结构

### 核心目录结构
```
YoloDotNet/
├── YoloDotNet/                 # 主项目
│   ├── Configuration/          # 配置相关
│   ├── Core/                   # 核心功能
│   ├── Enums/                  # 枚举定义
│   ├── Extensions/             # 扩展方法
│   ├── Handlers/               # 处理器
│   ├── Models/                 # 数据模型
│   ├── Modules/                # 检测模块
│   ├── Trackers/               # 跟踪器
│   ├── Video/                  # 视频处理
│   └── Yolo.cs                 # 主入口类
├── Demo/                       # 演示项目
├── test/                       # 测试项目
└── README.md                   # 项目说明
```

### 模块组织（Modules目录）
```
Modules/
├── Interfaces/                 # 接口定义
├── V5U/                       # YOLOv5u 模块
├── V8/                        # YOLOv8 模块
├── V8E/                       # YOLOv8E 模块
├── V9/                        # YOLOv9 模块
├── V10/                       # YOLOv10 模块
├── V11/                       # YOLOv11 模块
├── V11E/                      # YOLOv11E 模块
├── 12/                        # YOLOv12 模块
└── WorldV2/                   # YOLO-World 模块
```

## 支持的检测任务

### 1. Classification（图像分类）
**功能**: 对整个图像进行分类，识别图像中的主要对象类别

**支持模型**: YOLOv8, YOLOv11, YOLOv12
**主要方法**: `RunClassification(image, classes)`
**返回结果**: `List<Classification>` - 包含类别标签和置信度

**使用示例**:
```csharp
var results = yolo.RunClassification(image, classes: 1);
```

### 2. Object Detection（目标检测）
**功能**: 检测图像中的多个目标，返回边界框、类别和置信度

**支持模型**: YOLOv5u, YOLOv8, YOLOv9, YOLOv10, YOLOv11, YOLOv12, YOLO-World
**主要方法**: `RunObjectDetection(image, confidence, iou)`
**返回结果**: `List<ObjectDetection>` - 包含边界框、标签和置信度

**使用示例**:
```csharp
var results = yolo.RunObjectDetection(image, confidence: 0.15, iou: 0.7);
```

### 3. OBB Detection（定向边界框检测）
**功能**: 检测旋转目标，返回定向边界框（适用于航拍图像、文本检测等）

**支持模型**: YOLOv8, YOLOv11, YOLOv12
**主要方法**: `RunOBBDetection(image, confidence, iou)`
**返回结果**: `List<OBBDetection>` - 包含旋转边界框信息

### 4. Segmentation（像素级分割）
**功能**: 对检测到的目标进行像素级分割，生成精确的目标轮廓

**支持模型**: YOLOv8, YOLOv8E, YOLOv11, YOLOv11E, YOLOv12
**主要方法**: `RunSegmentation(image, confidence, pixelConfidence, iou)`
**返回结果**: `List<Segmentation>` - 包含分割掩码和边界框

**使用示例**:
```csharp
var results = yolo.RunSegmentation(image, confidence: 0.24, pixelConfedence: 0.5, iou: 0.7);
```

### 5. Pose Estimation（姿态估计）
**功能**: 检测人体关键点，用于姿态分析和动作识别

**支持模型**: YOLOv8, YOLOv11, YOLOv12
**主要方法**: `RunPoseEstimation(image, confidence, iou)`
**返回结果**: `List<PoseEstimation>` - 包含关键点坐标和连接信息

## 演示项目说明

### 基础演示项目
1. **ClassificationDemo** - 图像分类演示
2. **ObjectDetectionDemo** - 目标检测演示
3. **OBBDetectionDemo** - 定向边界框检测演示
4. **SegmentationDemo** - 分割演示
5. **PoseEstimationDemo** - 姿态估计演示

### 高级演示项目
6. **VideoStreamDemo** - 视频流处理演示（支持文件、直播流、摄像头）
7. **WebcamDemo** - WPF摄像头实时检测演示
8. **BatchDemo** - 批处理演示
9. **YoloE_SegmentationDemo** - YOLO-E零样本分割演示

## 基本使用流程

### 1. 初始化配置
```csharp
var yolo = new Yolo(new YoloOptions
{
    OnnxModel = "model.onnx",           // 模型路径或字节数组
    Cuda = true,                        // 启用GPU加速
    PrimeGpu = true,                    // GPU预热
    GpuId = 0,                          // GPU设备ID
    ImageResize = ImageResize.Proportional  // 图像缩放方式
});
```

### 2. 加载图像
```csharp
using var image = SKBitmap.Decode("image.jpg");
```

### 3. 运行推理
```csharp
var results = yolo.RunObjectDetection(image, confidence: 0.20, iou: 0.7);
```

### 4. 绘制结果
```csharp
image.Draw(results, drawingOptions);
```

### 5. 保存结果
```csharp
image.Save("result.jpg");
```

## 配置选项

### YoloOptions 主要参数
- **OnnxModel**: 模型文件路径或字节数组
- **Cuda**: 是否启用CUDA加速
- **PrimeGpu**: 是否进行GPU预热
- **GpuId**: GPU设备索引
- **ImageResize**: 图像缩放模式（Proportional/Stretched）
- **SamplingOptions**: 图像采样选项

### 绘制选项
每种检测任务都有对应的绘制选项类：
- **DetectionDrawingOptions**: 目标检测绘制选项
- **ClassificationDrawingOptions**: 分类绘制选项  
- **SegmentationDrawingOptions**: 分割绘制选项
- **PoseEstimationDrawingOptions**: 姿态估计绘制选项

## 性能优化

### v3.0 性能提升
| 任务类型 | 设备 | 速度提升 | 内存减少 |
|---------|------|----------|----------|
| 分割 | GPU | 高达70.8% | 高达92.7% |
| 分类 | GPU | 高达28.5% | 高达46.1% |
| OBB检测 | GPU | 高达28.7% | 高达2.2% |
| 姿态估计 | GPU | 高达27.6% | 高达0.7% |
| 目标检测 | GPU | 高达25.0% | 高达0.8% |

### 优化建议
1. **启用CUDA**: 对于实时应用，强烈建议使用GPU加速
2. **模型选择**: 根据精度和速度需求选择合适的模型版本
3. **图像预处理**: 选择合适的ImageResize模式
4. **批处理**: 对于大量图像，使用批处理可提高效率

## 环境要求

### 基础要求
- .NET 6.0 或更高版本
- ONNX Runtime 1.22.1
- SkiaSharp 3.119.0

### GPU加速要求
- CUDA Toolkit 12.x
- cuDNN 9.x
- 兼容的NVIDIA GPU

### 视频处理要求
- FFmpeg 和 FFprobe（需添加到系统PATH）

## 模型导出要求

所有YOLO模型必须导出为ONNX格式，opset版本为17：
```bash
# Ultralytics导出示例
yolo export model=yolov8n.pt format=onnx opset=17
```

## 许可证

YoloDotNet 使用 GNU General Public License v3.0 许可证。
