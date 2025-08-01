﻿// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (c) 2024-2025 Niklas Swärd
// https://github.com/NickSwardh/YoloDotNet

global using System;
global using System.IO;
global using System.Buffers;
global using System.Globalization;
global using System.Collections.Generic;

global using Microsoft.VSDiagnostics;
global using Microsoft.ML.OnnxRuntime.Tensors;

global using YoloDotNet.Enums;
global using YoloDotNet.Models;
global using YoloDotNet.Handlers;
global using YoloDotNet.Extensions;
global using YoloDotNet.Test.Common;
global using YoloDotNet.Configuration;
global using YoloDotNet.Benchmarks.Setup;
global using YoloDotNet.Test.Common.Enums;

global using SkiaSharp;
global using PoseEstimationDemo;

global using BenchmarkDotNet.Configs;
global using BenchmarkDotNet.Reports;
global using BenchmarkDotNet.Running;
global using BenchmarkDotNet.Attributes;
