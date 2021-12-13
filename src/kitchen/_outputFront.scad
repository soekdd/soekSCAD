include <front.scad>
material = 1;
if (material == 0)
    front();
else {
    boards(material);
}
