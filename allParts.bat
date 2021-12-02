for /l %%x in (0, 1, 27) do (
  echo generating part %%x
  openscad src/kitchen/_outputPart.scad -D partNo=%%x -o output/kitchen/parts/part%%x.stl >>output/logs/part%%x.log
  REM openscad src/kitchen/_outputPart.scad -D partNo=%%x -o output/kitchen/test/part%%x.stl >>output/logs/partTest%%x.log
)

