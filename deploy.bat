@echo off
setlocal enabledelayedexpansion

REM 设置你的用户名和邮箱（如果还没设置）
git config --global user.email "your-email@example.com"
git config --global user.name "The_FatFish"

REM [1/5] 进入 quartz 目录
echo [1/5] 正在进入 Quartz 项目目录...
cd /d "C:\Users\15481\quartz"
if %errorlevel% neq 0 (
    echo ❌ 无法进入目录 C:\Users\15481\quartz，请检查路径是否正确。
    pause
    exit /b
)

REM [2/5] 生成网站文件
echo [2/5] 正在生成网站文件...
npx quartz build
if %errorlevel% neq 0 (
    echo ❌ 网站生成失败！请检查是否有报错。
    pause
    exit /b
)

REM [3/5] 进入 public 目录
echo [3/5] 正在进入 public 目录...
cd public
if %errorlevel% neq 0 (
    echo ❌ 无法进入 public 目录，请确认 quartz\public 文件夹存在。
    pause
    exit /b
)

REM [4/5] 初始化 Git 仓库（如果尚未初始化）
if not exist ".git" (
    echo [4/5] 正在初始化 Git 仓库...
    git init
    if %errorlevel% neq 0 (
        echo ❌ Git 初始化失败！
        pause
        exit /b
    )
)

REM [5/5] 提交并推送
echo [5/5] 正在提交并推送到 GitHub...
git add .
git commit -m "Update website: %date%"
git remote add origin https://github.com/LOLOLTheFatFish/The-FatFish-Blog_Website.git 2>nul
git remote set-url origin https://github.com/LOLOLTheFatFish/The-FatFish-Blog_Website.git
git branch -M main
git push -u origin main --force

echo ✅ 部署完成！请等待 1-2 分钟后访问你的网站：
echo https://LOLOLTheFatFish.github.io/The-FatFish-Blog_Website

pause