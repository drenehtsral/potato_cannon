$fs=0.1;
$fn=120;

/*
 * If you'd like the resulting projectile to contain a hollow center, set hollow
 * to a value > 0.  Some reasons you might want a hollow projectile are to
 * embed a telemetry device (or a firecracker), or to fill the center with
 * silicone rubber to provide mass and durability.
 */
hollow=0;

/*
 * shrinkage holds a scaling factor for shrinkage compensation since most
 * plastics as printed by a normal fused-filament type 3D printer will shrink
 * a little as they cool and to work well in the potato cannon you need the
 * projectile to fit snugly in the barrel.
 *
 * For HatchBox PLA filament I've found that 3.5% is a decent estimate of
 * shrinkage for this sort of print but depending on your printer, printing
 * temperature, filament, and the manufacturing tolerance on PVC pipe you
 * may need to tweak this value a bit.
 */
shrinkage_comp = 1.035;

/*
 * Set rifle=true to rifle the slug, or rifle=false to leave it plain.
 */
rifle=true;

scale(shrinkage_comp)difference() {
    union() {
        translate([0,0,0])cylinder(r1=17.5, r2=20, h=5);
        translate([0,0,5])cylinder(r=20, h=40);
        translate([0,0,45]) scale([1,1,2]) sphere(r=20);
    }
    union() {
        if (rifle) {
            translate([0,0,-0.1])linear_extrude(height=120, twist=360) {
                for(th=[0:90:359]) rotate([0,0,th])translate([20,0]) circle(r=1.5);
            }
        }
        if (hollow > 0) {
            hr = hollow / 2;
            translate([0,0,0]) cylinder(r1 = hr * (17.5/20), r2 = hr, h=5);
            translate([0,0,5])cylinder(r=hr, h=40);
            translate([0,0,45]) scale([1,1,2]) sphere(r=hr);
        }
    }
}

