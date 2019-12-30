use <conversions.scad>;


total_height = inch_to_mm(.367);

module mil_std_1913(segments) {
  period = inch_to_mm(.394);
  groove_width = inch_to_mm(.206); // +.008
  groove_depth = inch_to_mm(.118); // +.008
  land_width = period - groove_width;

  width = land_width + segments * (groove_width + land_width);

  difference() {
    linear_extrude(width) {
      mil_std_1913_profile();
    }
    for (i = [0:segments - 1 ]) {
      translate([-20,total_height - groove_depth,land_width + (i * period)]) {
        cube([40, groove_depth + 1, groove_width]);
      }
    }
  }
}

module mil_std_1913_profile() {
  total_width = inch_to_mm(.835);
  // base
  base_width = inch_to_mm(.617);
  // top
  // square([inch_to_mm(.835), 1]);
  // top central section
  central_section_width = inch_to_mm(.748);
  central_section_height = inch_to_mm(.108);
  union() {
    translate([-base_width / 2, 0]) {
      square([base_width, total_height]);
    };
    difference() {
      translate([-central_section_width / 2, total_height - inch_to_mm(.164)]) {
        hull() {
          // left angle
          translate([-central_section_height / 2, central_section_height / 2]) {
            rotate([0,0,-45]) {
              square([central_section_height * 2, central_section_height * 2]);
            }
          }
          // right angle
          translate([central_section_width + central_section_height / 2, central_section_height / 2]) {
            rotate([0,0,135]) {
              square([central_section_height * 2, central_section_height * 2]);
            }
          }
        }
      }
      translate([-total_width, total_height]) {
        square([total_width * 2, total_height]);
      };
    }
  }
}

mil_std_1913(5);
