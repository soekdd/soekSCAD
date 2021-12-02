include <front.scad>
material = 0;
if (material == 0)
    front();
else {
    boards(material);
}
