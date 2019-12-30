$fa = 1;
$fs = 0.4;

module spitzer_bullet(
  d=10,
  l=undef, // overall length
  ogive_radii=6, // radii of ogive
  cylinder_l=undef, // length of straight portion
  frustum_l=undef,  // length of frustum ("boattail")
  frustum_d=undef, // small diameter of frustum ("boattail")
) {
  o_l = ogive_length(d, ogive_radii);
  f_d = frustum_d == undef ? d - d/5 : frustum_d;
  f_l = frustum_l == undef ? 4 : frustum_l;
  c_l =
    cylinder_l == undef ?
      l == undef ? 10 : l - o_l - f_l
      : cylinder_l;

  union() {
    cylinder(d1=f_d, d2=d, h=f_l);
    translate([0,0,f_l]) {
      cylinder(d=d, h=c_l);
    }
    translate([0,0,f_l + c_l]) {
      tangent_ogive(d, R=ogive_radii);
    }
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

function ogive_length(d, R) =
  // equivalent to finding the positive y-intercept for either circle
  sqrt(pow(R*d, 2) - pow(R*d - d/2, 2));
