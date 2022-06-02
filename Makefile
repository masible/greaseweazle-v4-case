all: gw4-big-bottom.stl gw4-big-top.stl gw4-small-bottom-front.stl gw4-small-bottom-back.stl gw4-small-top-front.stl gw4-small-top-middle.stl gw4-small-top-back.stl

gw4-big-bottom.stl: GW\ v4\ -\ Box.scad GW\ v4.scad
	echo "use <GW v4.scad> case_bottom();" | openscad -o $@ -

gw4-big-top.stl: GW\ v4\ -\ Box.scad GW\ v4.scad
	echo "use <GW v4.scad> case_top();" | openscad -o $@ -

gw4-small-bottom-front.stl: GW\ v4\ -\ Box.scad GW\ v4.scad
	echo "use <GW v4.scad> case_bottom_front();" | openscad -o $@ -

gw4-small-bottom-back.stl: GW\ v4\ -\ Box.scad GW\ v4.scad
	echo "use <GW v4.scad> case_bottom_back();" | openscad -o $@ -

gw4-small-top-front.stl: GW\ v4\ -\ Box.scad GW\ v4.scad
	echo "use <GW v4.scad> case_top_front();" | openscad -o $@ -

gw4-small-top-middle.stl: GW\ v4\ -\ Box.scad GW\ v4.scad
	echo "use <GW v4.scad> case_top_middle();" | openscad -o $@ -

gw4-small-top-back.stl: GW\ v4\ -\ Box.scad GW\ v4.scad
	echo "use <GW v4.scad> case_top_back();" | openscad -o $@ -

clean:
	rm -f gw4-big-bottom.stl gw4-big-top.stl \
		gw4-small-bottom-front.stl gw4-small-bottom-back.stl \
		gw4-small-top-front.stl gw4-small-top-middle.stl gw4-small-top-back.stl
