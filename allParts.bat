echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set outDir=parts
set cpuNum=5
set partNum=35

set /a eachParts=%partNum%/%cpuNum%

echo eachParts %eachParts%
set start=0
set /a loopNum = %cpuNum% - 2
for /l %%x in (0, 1, %loopNum%) do call :execPart %%x
goto :execEnd

:execPart
  set /a from = %~n1 * %eachParts%
  set /a to = (%~n1 * %eachParts%) + %eachParts% - 1
  echo %~n1 partLoop start %start% from %from% o %to%
  start /min /IDLE partLoop.bat %from% %to% %outDir%
goto :eof

:execEnd
  set /a from = (%cpuNum% - 1) * %eachParts%
  set /a to = partNum
  echo %~n1 partLoop start %start% from %from% o %to%
  start /min /IDLE partLoop.bat %from% %to% %outDir%
