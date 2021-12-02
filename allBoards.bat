for /l %%x in (0, 1, 3) do (
  echo generating board... %%x
  openscad src/kitchen/_outputfront.scad -D material=%%x -o output/kitchen/boards/board%%x.stl >>output/logs/boards.log
)

