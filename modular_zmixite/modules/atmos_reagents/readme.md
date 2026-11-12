## Atmos Reagents

MODULE ID: ATMOS_REAGENTS

### Description:

Adds reagent support to atmos. Liquids can now be stored inside pipelines, portable atmos machines, and gas tanks, taking up space that would otherwise be occupied by gas. As reagents are added, the available gas volume decreases and pressure gets displaced accordinly. Containers use their full internal volume for reagent storage (`REAGENT_VOLUME_RATIO` is 100%).

Reagents in pipelines are shared across the entire pipeline and process alongside the gas mixture. They exchange heat with the gas in both directions and can run their own atmos tick logic through `/datum/reagent/proc/on_atmos_tick`. Connected atmos machinery can also handle reagent ticks through `/obj/machinery/atmospherics/proc/on_atmos_reagent_tick`.

Portable atmos machines work similarly, with their reagents processing alongside the machine and exchanging heat with its air contents. Their `suppress_reactions` flag is checked. Gas tanks also exchange heat with their stored reagents.

The usual atmos machinery handles reagents in these ways:

- **Vent pumps** scoop reagents when siphoning and spill them when releasing, **scrubbers** scoop when siphoning, and **passive vents** scoop or spill whichever side has more liquid. Scrubbers drown thus refuse to work while sitting in liquid.
- **Pressure and volume pumps** move reagents along with the gas when running.
- **Gates** (temperature, pressure, passive) pass reagents whenever they pass gas, and **valves** equalize reagent concentration between both sides when opened.
- **Connector ports** transfer pipeline reagents into the connected machine.
- **Portable pumps and scrubbers** move reagents between their holding tank and the surrounding atmos.
- **Canisters** transfer reagents into their holding tank when the valve is open, or spill them onto the turf if no tank is connected.

### TG Proc Changes:

- `code/controllers/subsystem/air.dm`
  - `/datum/controller/subsystem/air/process_rebuilds`
  - `/datum/controller/subsystem/air/process_atmos_machinery`
- `code/game/objects/items/tanks/tanks.dm`
  - `/obj/item/tank/Initialize`
  - `/obj/item/tank/Destroy`
  - `/obj/item/tank/process`
- `code/modules/mob/living/carbon/life.dm`
  - `/mob/living/carbon/get_breath_from_internal`
- `code/modules/atmospherics/machinery/datum_pipeline.dm`
  - `/datum/pipeline/New`
  - `/datum/pipeline/Destroy`
  - `/datum/pipeline/process`
  - `/datum/pipeline/build_pipeline`
  - `/datum/pipeline/build_pipeline_blocking`
  - `/datum/pipeline/add_member`
  - `/datum/pipeline/merge`
  - `/datum/pipeline/temporarily_store_air`
- `code/modules/atmospherics/machinery/pipes/pipes.dm`
  - `/obj/machinery/atmospherics/pipe/set_volume`
- `code/modules/atmospherics/machinery/portable/canister.dm`
  - `/obj/machinery/portable_atmospherics/canister/canister_break`
  - `/obj/machinery/portable_atmospherics/canister/process_atmos`
- `code/modules/atmospherics/machinery/portable/portable_atmospherics.dm`
  - `/obj/machinery/portable_atmospherics/Initialize`
  - `/obj/machinery/portable_atmospherics/Destroy`

### Modular Overrides:

- `modular_zmixite/master_files/code/modules/machinery/datum_pipeline.dm`
  - new var: `/datum/pipeline/reagents`
  - new var: `/datum/pipeline/physical_volume`
  - `/obj/machinery/atmospherics/pipe/add_member`
- `modular_zmixite/modules/atmos_reagents/code/atmos_reagents.dm`
  - `/datum/reagent/on_atmos_tick`
  - `/obj/machinery/atmospherics/on_atmos_reagent_tick`
  - `/obj/machinery/process_atmos_reagents`
- `modular_zmixite/modules/atmos_reagents/code/pipeline.dm`
  - `/datum/pipeline/update_reagent_capacity`
  - `/datum/pipeline/on_reagents_changed`
  - `/datum/pipeline/process_reagents`
  - `/datum/pipeline/process_reagent_temperature`
  - `/datum/pipeline/spill_reagents`
- `modular_zmixite/modules/atmos_reagents/code/portable_atmospherics.dm`
  - `/obj/machinery/portable_atmospherics/initialize_reagents`
  - `/obj/machinery/portable_atmospherics/update_reagent_capacity`
  - `/obj/machinery/portable_atmospherics/on_reagents_changed`
  - `/obj/machinery/portable_atmospherics/process_reagents`
  - `/obj/machinery/portable_atmospherics/process_reagent_temperature`
  - `/obj/machinery/portable_atmospherics/spill_reagents`
  - `/obj/machinery/portable_atmospherics/process_atmos_reagents`
  - `/obj/machinery/portable_atmospherics/pump/process_atmos_reagents`
  - `/obj/machinery/portable_atmospherics/scrubber/process_atmos_reagents`
- `modular_zmixite/modules/atmos_reagents/code/tank.dm`
  - `/obj/item/tank/initialize_reagents`
  - `/obj/item/tank/on_reagents_changed`
  - `/obj/item/tank/update_reagent_capacity`
  - `/obj/item/tank/process_reagents`
  - `/obj/item/tank/process_reagent_temperature`
  - `/obj/item/tank/spill_reagents`
- `modular_zmixite/modules/atmos_reagents/code/unary.dm`
  - `/obj/machinery/atmospherics/components/unary/scoop_reagents`
  - `/obj/machinery/atmospherics/components/unary/spill_reagents`
  - `/obj/machinery/atmospherics/components/unary/transfer_reagents`
  - `/obj/machinery/atmospherics/components/unary/portables_connector/process_atmos`
  - `/obj/machinery/atmospherics/components/unary/passive_vent/process_atmos`
  - `/obj/machinery/atmospherics/components/unary/vent_pump/process_atmos`
  - `/obj/machinery/atmospherics/components/unary/vent_scrubber/should_atmos_process`
  - `/obj/machinery/atmospherics/components/unary/vent_scrubber/atmos_expose`
- `modular_zmixite/modules/atmos_reagents/code/binary.dm`
  - `/obj/machinery/atmospherics/components/binary/transfer_reagents`
  - `/obj/machinery/atmospherics/components/binary/equalize_reagents`
  - `/obj/machinery/atmospherics/components/binary/valve/return_pipenets_for_reconcilation`
  - `/obj/machinery/atmospherics/components/binary/temperature_gate/process_atmos_reagents`
  - `/obj/machinery/atmospherics/components/binary/pressure_valve/process_atmos_reagents`
  - `/obj/machinery/atmospherics/components/binary/passive_gate/process_atmos_reagents`
  - `/obj/machinery/atmospherics/components/binary/pump/process_atmos_reagents`
  - `/obj/machinery/atmospherics/components/binary/volume_pump/process_atmos_reagents`
- `modular_zmixite/modules/atmos_reagents/code/canister.dm`
  - `/obj/machinery/portable_atmospherics/canister/release_reagents`

### Defines:

- `code/__DEFINES/~zmixite_defines/atmos.dm`
  - `REAGENT_VOLUME_RATIO`: fraction of internal volume used as reagent capacity
  - `MINIMUM_GAS_VOLUME`: smallest gas volume left when liquids displace gas
  - `TANK_REAGENTS_INGEST_ON_BREATH_AMOUNT`: reagents ingested per breath from internals

### Included files that are not contained in this module:

- `code/__DEFINES/~zmixite_defines/atmos.dm`
