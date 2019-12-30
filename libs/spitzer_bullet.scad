$fa = 1;
$fs = 0.4;

module spitzer_bullet(d=10, ogive_radius=6) {
  cylinder_h = 20;
  frustum_h = 4;
  frustum_d = 8;

  cylinder(d1=frustum_d, d2=d, h=frustum_h);
  translate([0,0,frustum_h]) {
    cylinder(d=d, h=cylinder_h);
  }
  translate([0,0,frustum_h + cylinder_h]) {
    tangent_ogive(d, R=ogive_radius);
  }
}

module tangent_ogive(d, R=6) {
  // Reference: https://www.mathscinotes.com/2011/01/ballistics-ogives-and-bullet-shapes-part-1/
  R_offset = R - 0.5;
  rotate_extrude() {
    rotate([0,0,270]) {
      difference() {
        intersection() {
          translate([0,R_offset*d]) {
            circle(r=R*d);
          }
          translate([0,-R_offset*d]) {
            circle(r=R*d);
          }
        }
        union() {
          translate([0,-d*5]) {
            square([d*10, d*10]);
          }
          translate([-d*5, 0]) {
            square([d*10, d*10]);
          }
        }
      }
    }
  }
}
