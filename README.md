# PDFMaker 图片转 PDF 工具
![Windows](https://img.shields.io/badge/platform-Windows-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Version](https://img.shields.io/badge/version-1.0.0-orange)
## 简介

PDFMaker 是一款基于 Windows 的图片批量转换 PDF 工具。

支持通过拖拽或菜单方式，将图片、文件夹、ZIP 压缩包快速转换为 PDF 文件。

设计目标：

* 简单易用
* 无需复杂配置
* 支持大量图片处理
* 保留原始图片清晰度
* 兼容中文文件名

---

# 功能特点

## 图片转 PDF

支持格式：

* JPG / JPEG
* PNG
* BMP
* WEBP
* 其他 ImageMagick 支持格式

支持：

* 单张图片转换 PDF
* 多张图片合并为一个 PDF
* 图片顺序保持原始顺序

---

## ZIP 文件处理

支持直接拖入 ZIP 文件：

自动完成：

1. 解压 ZIP
2. 扫描图片
3. 分类整理
4. 生成 PDF
5. 打包输出 ZIP

无需手动解压。

---

## 文件夹处理

支持直接拖入文件夹：

例如：

```
照片文件夹
│
├── 001.jpg
├── 002.jpg
└── 003.png
```

程序会自动扫描其中所有图片。

---

## 智能分组

支持根据文件名自动匹配：

例如：

```
001.jpg
001(1).jpg

002.jpg
002(1).jpg
```

自动生成：

```
001.pdf
002.pdf
```

如果只有一张：

```
003.jpg
```

也会生成：

```
003.pdf
```

---

## 图片优化

支持：

* 自动识别手机照片方向
* 自动旋转横竖照片
* 保持图片比例
* 自动适配页面尺寸
* 防止裁剪
* 防止拉伸

---

# 安装方法

## 自动安装

运行：

```
PDFMaker_Installer.bat
```

安装程序会自动：

1. 创建：

```
C:\PDFMaker
```

2. 部署核心文件：

```
C:\PDFMaker
│
├── 图片转PDF.bat
└── 图片转PDF.ps1
```

3. 检测并安装：

* ImageMagick
* 7-Zip

4. 创建桌面快捷方式：

```
PDFMaker.lnk
```

---

# 使用方法

## 方法一：拖拽转换（推荐）

直接拖入：

* 图片
* 多张图片
* ZIP 文件
* 文件夹

到：

```
图片转PDF.bat
```

程序自动处理。

---

## 方法二：桌面快捷方式

双击：

```
PDFMaker.lnk
```

进入菜单：

```
==========================
       Image To PDF Tool
==========================

1. Select images / ZIP

2. Select folder

3. Exit
```

选择对应功能即可。

---

# 输出规则

## PDF输出

单组图片：

```
001.jpg
```

生成：

```
001.pdf
```

多张图片：

```
001.jpg
002.jpg
003.jpg
```

生成：

```
001.pdf
```

---

## ZIP输出

生成位置：

```
桌面
```

文件名：

```
PDF_Output_YYYYMMDD_HHMMSS.zip
```

例如：

```
PDF_Output_20260708_184756.zip
```

---

# 软件依赖

## ImageMagick

用途：

* 图片读取
* PDF生成
* EXIF方向识别

## 7-Zip

用途：

* ZIP文件解压

安装器会自动处理。

---

# 系统要求

支持：

* Windows 10
* Windows 11

建议：

* PowerShell 5.1+
* 管理员权限安装

---

# 常见问题

## 1. PDF为空

检查：

* ImageMagick 是否安装成功
* 图片格式是否支持

重新运行安装器即可。

---

## 2. 中文文件名乱码

请确保：

* Windows 系统语言支持中文
* 使用最新版脚本

程序已针对中文路径优化。

---

## 3. 手机照片方向错误

程序使用：

```
-auto-orient
```

自动读取 EXIF 信息修正方向。

---

# 项目结构

```
PDFMaker
│
├── 安装PDFMaker_最终稳定版.bat
│
└── 安装后
    │
    └── C:\PDFMaker
        │
        ├── 图片转PDF.bat
        │
        └── 图片转PDF.ps1
```

---

# 更新记录

## v1.0

新增：

* 图片转PDF
* ZIP处理
* 文件夹处理
* 自动分组
* 中文路径支持
* 自动旋转手机照片
* 自动安装环境
* 桌面快捷方式

---

# 开源组件

本项目依赖：

* ImageMagick
* 7-Zip
* Windows PowerShell

感谢这些优秀的开源项目。

---

# 作者 Ray

PDFMaker Tool

Windows 图片转 PDF 自动化工具


