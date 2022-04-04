echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set outDir=single
set part=15

partLoop.bat %part% %part% %outDir%
