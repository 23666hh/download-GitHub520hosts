$url = "https://raw.hellogithub.com/hosts"
$desktopPath = [Environment]::GetFolderPath("Desktop")
$outputPath = Join-Path -Path $desktopPath -ChildPath "github_hosts.txt"

try {
    Write-Host "正在下载 GitHub hosts 文件..." -ForegroundColor Cyan
    
    # 使用 Invoke-RestMethod 发送请求获取文本
    $content = Invoke-RestMethod -Uri $url -Method Get
    
    # 保存为文本文件
    $content | Out-File -FilePath "$outputPath" -Encoding UTF8 -NoNewline
    
    Write-Host "下载成功！文件已保存到：$outputPath" -ForegroundColor Green
    
    # 显示前10行内容预览
    Write-Host "`n文件前10行内容预览：" -ForegroundColor Cyan
    $content -split "`n" | Select-Object -First 10 | ForEach-Object {
        Write-Host "| $_"
    }

    Start-Sleep 3
}
catch {
    Write-Host "下载失败！错误信息: $_" -ForegroundColor Red
    Write-Host "建议尝试以下解决方法：" -ForegroundColor Yellow
    Write-Host "1. 检查网络连接是否正常"
    Write-Host "2. 临时关闭防火墙或安全软件试试"
    Write-Host "3. 使用管理员权限运行 PowerShell"
}