echo off
set from=%1
set to=%2
set outDir=%3
echo start part generation from %from% to %to%
for /l %%x in (%from%, 1, %to%) do (
  echo generating part %%x at %DATE:/=-% %TIME::=:%
  openscad src/kitchen/_outputPart.scad -D partNo=%%x -o output/kitchen/%outDir%/part%%x.svg >output/logs/part%%x.log
)

