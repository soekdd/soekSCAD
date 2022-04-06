echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set outDir=single
set part=32

partLoop.bat %part% %part% %outDir%
