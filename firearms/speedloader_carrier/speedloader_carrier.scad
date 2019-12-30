$fn = 180;

// Height of the carrier, not considering the belt loop
carrier_h = 30;
// Thickness of the walls. 3mm seems sufficent and not too heavy.
carrier_wall = 3;

// height of the speedloader body. Designed for a Safariland Comp I
sl_body_h = 5;
// diameter of the speedloader body
sl_body_d = 34;

// Derived from Hornady Critical Defense .38
// cartridge diameter
cartridge_d = 10;
// cartridge height
cartridge_h = 22;

// distance from the cartridge to the wall of the carrier
cartridge_from_wall = 1.5;

// the "ejector" star that holds the cartridges in place
star_d = 14;
star_h = 8;

// derived from a Hank's "Black Out" belt (1.5", 17oz)
// https://www.hanksbelts.com/collections/mens-gun-belts/products/hanks-tactical-blackout-extreme-belt
// dimensions for the user's belt
belt_w = 7.5;
// height is slightly oversized
belt_h = 40;

// carrier body
difference() {
  // overall shape of the carrier
  cylinder(
    d=sl_body_d + 2 * carrier_wall,
    h=carrier_h
  );
  // speedloader body hole
  translate([0,0,carrier_h - sl_body_h]) {
    cylinder(d=34.5,h=sl_body_h + 1);
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
        translate([0,belt_h - belt_w / 2,0]) {
          cylinder(d=11.5, h=40);
        }
      }
      hull() {
        translate([0,0,-1]) {
          cylinder(d=belt_w, h=42);
        }
        translate([0,belt_h - belt_w /2,-1]) {
          cylinder(d=belt_w, h=42);
        }
      }
    }
  }
};

module cartridge_hole() {
  translate([
    ((sl_body_d - cartridge_d) / 2) - cartridge_from_wall,
    0,
    carrier_h - sl_body_h - cartridge_h,
  ]) {
    cylinder(d=cartridge_d, h=cartridge_h + 1);
  };
};

module star_hole() {
  translate([0,0,carrier_h - sl_body_h - star_h]) {
    cylinder(d=star_d,h=star_h + 1);
  };
};
