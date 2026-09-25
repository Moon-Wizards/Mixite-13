https://github.com/Moon-Wizards/Mixite-13/pulls

## HYDRAKIN
Module ID: HYDRAKIN

### Description:
This module ports the Hydrakin species from [Monolith (SS14)](https://github.com/Monolith-Station/Monolith) to Mixite/13.
Hydrakin are a humanoid avian species, their differences are:
- Strange headshape, can't wear eyewear.
- Affinity for the cold, with overheating that needs to be managed manually.
- Ability to breathe (almost) all gasses, with some providing benefits.

### TG Proc/File Changes:
- `sound/items/weapons/slash.ogg` -> For the bodypart arms, when attacking
- `sound/items/weapons/slashmiss.ogg` -> For the bodypart arms, when attacking
- `code/_globalvars/traits/_traits.dm` -> Added `TRAIT_HYDRAKIN_THERMAL` to /mob
- `code/__DEFINES/~~zmixite_defines/DNA.dm` -> Added `SPECIES_HYDRAKIN`
- `code/__DEFINES/~~zmixite_defines/is_helper.dm` -> Added `ishydrakin()`
- `config/game_options.txt` -> Added hydrakin to the roundstart races

### Modular Overrides:
None, I think?

### Defines:
- `SPECIES_HYDRAKIN` in `code/__DEFINES/~~zmixite_defines/DNA.dm`
- `TRAIT_HYDRAKIN_THERMAL` in `code/__DEFINES/~~zmixite_defines/traits/declarations.dm`

### Included files that are not contained in this module:
- `code/modules/unit_tests/screenshots/screenshot_humanoids__datum_species_hydrakin.png` -> Necessary for the unit tests to pass

### Credits:
[Zenthine07](https://github.com/Zethine07): Species concept and original sprite work.
[snebl](https://github.com/snebl): Originally developing Hydrakin for [SS14/Obelisk](https://github.com/Obelisk-Sector/Obelisk/pull/1).
[Redrover1760](https://github.com/Redrover1760): Maintaining and continuing Hydrakin to [SS14/Monolith](https://github.com/Monolith-Station/Monolith/pull/2644).
[Technetyzed](https://github.com/Technetyzed): Porting Hydrakin to SS13/Mixite/13, New Hydrakin content
