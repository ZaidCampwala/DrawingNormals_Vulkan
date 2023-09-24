@echo off

set filename=%1

set filename=%filename:"=%

set output=%filename%.spv

echo Compiling: %filename%

if exist %output% ( del %output% )
C:/VulkanSDK/1.3.224.1/Bin/glslc.exe -c "%filename%" -o "%output%"
echo Created spv file: %output%
pause
