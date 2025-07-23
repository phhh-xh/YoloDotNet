# 批量升级插件项目到.NET 8.0
# PowerShell脚本

Write-Host "开始批量升级插件项目到.NET 8.0..." -ForegroundColor Green

# 获取所有需要升级的.csproj文件
$pluginProjects = Get-ChildItem -Path "02Plugins" -Filter "*.csproj" -Recurse

Write-Host "找到 $($pluginProjects.Count) 个插件项目需要升级" -ForegroundColor Yellow

$successCount = 0
$failCount = 0

foreach ($project in $pluginProjects) {
    try {
        Write-Host "正在升级: $($project.FullName)" -ForegroundColor Cyan
        
        # 读取项目文件内容
        $content = Get-Content $project.FullName -Raw
        
        # 替换TargetFramework
        $newContent = $content -replace '<TargetFramework>net6\.0-windows</TargetFramework>', '<TargetFramework>net8.0-windows</TargetFramework>'
        
        # 如果内容有变化，写回文件
        if ($newContent -ne $content) {
            Set-Content -Path $project.FullName -Value $newContent -Encoding UTF8
            Write-Host "  ✓ 升级成功" -ForegroundColor Green
            $successCount++
        } else {
            Write-Host "  - 无需升级" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host "  ✗ 升级失败: $($_.Exception.Message)" -ForegroundColor Red
        $failCount++
    }
}

Write-Host "`n升级完成!" -ForegroundColor Green
Write-Host "成功: $successCount 个项目" -ForegroundColor Green
Write-Host "失败: $failCount 个项目" -ForegroundColor Red

if ($failCount -eq 0) {
    Write-Host "`n所有插件项目已成功升级到.NET 8.0!" -ForegroundColor Green
}
