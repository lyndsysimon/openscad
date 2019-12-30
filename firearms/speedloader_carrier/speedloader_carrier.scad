$fa = 1;
$fs = 0.4;

/* [Belt] */

// Default values derived from a Hank's "Black Out" belt (1.5", 17oz)
// https://www.hanksbelts.com/collections/mens-gun-belts/products/hanks-tactical-blackout-extreme-belt

// Width of your belt - *in inches*
belt_width = 1.5; // [.5:2]

// Thickness of your belt
belt_thickness = 17; // [6:20]

/* [Speedloader Carrier] */
rim_height = 5; // [0:30]

// Length of the cartridge *that extends below the speedloader*
// NOTE: This will eventually be refactored to be the cartridge OAL.
cartridge_length = 22;

// Thickness of the walls. 3mm seems sufficent and not too heavy.
carrier_wall = 3;

/* [Hidden] */

// convert belt size from inches
//   1" == 25.4mm
belt_height = belt_width * 25.4;

// convert belt thickness from ounces
//   1 oz == 0.4mm
belt_w = belt_thickness * 0.4;
speedloader_diameter = 34;

carrier_base_height = cartridge_length + carrier_wall;

// Derived from Hornady Critical Defense .38
// cartridge diameter
cartridge_d = 10;
// cartridge height - the portion that extends below the speedloader.
cartridge_h = cartridge_length;

// the "ejector" star that holds the cartridges in place
star_d = 14;
star_h = 8;

// carrier body
difference() {
  // overall shape of the carrier
  cylinder(
    d=speedloader_diameter + 2 * carrier_wall,
    h=carrier_base_height + rim_height
  );
  // speedloader body hole
  translate([0,0,carrier_base_height]) {
    cylinder(d=34.5,h=rim_height + 1);
  };
  // cartridge holes
  group() {
    cartridge_hole();
    rotate(a=[0,0,360 / 5]) {
      cartridge_hole();
    }
    rotate(a=[0,0,360 / 5 * 2]) {
      cartridge_hole();
    }
    rotate(a=[0,0,360 / 5 * 3]) {
      cartridge_hole();
    }
    rotate(a=[0,0,360 / 5 * 4]) {
      cartridge_hole();
    }
  };
  // hole for the star that holds the cartridges in place
  star_hole();
};

// Belt loop
translate([-24,20,belt_w / 2 + 2]) {
  rotate([90,0,0]) {
    difference() {
      hull() {
        cylinder(d=11.5, h=40);
        translate([0,belt_height - belt_w / 2,0]) {
          cylinder(d=11.5, h=40);
        }
      }
      hull() {
        translate([0,0,-1]) {
          cylinder(d=belt_w, h=42);
        }
        translate([0,belt_height - belt_w /2,-1]) {
          cylinder(d=belt_w, h=42);
        }
      }
    }
  }
};

module cartridge_hole() {
  // distance from the cartridge to the wall of the carrier
  cartridge_from_wall = 1.5;

  translate([
    ((speedloader_diameter - cartridge_d) / 2) - cartridge_from_wall,
    0,
    carrier_base_height - cartridge_h,
  ]) {
    cylinder(d=cartridge_d, h=cartridge_h + 1);
  };
};

module star_hole() {
  translate([0,0,carrier_base_height - star_h]) {
    cylinder(d=star_d,h=star_h + 1);
  };
};
