## Title: Cargo

MODULE ID: CARGO

### Description:

Cargo but you drive shuttle, viva la Space Station 14.

### TG Proc/File Changes:

- `code/modules/cargo/exports.dm`: `proc/export_item_and_contents`
- `code/modules/cargo/order.dm`: `/datum/supply_order/proc/generate`
- `code/modules/cargo/orderconsole.dm`: `/obj/machinery/computer/cargo/ui_data`, `/obj/machinery/computer/cargo/ui_act`
- `code/modules/cargo/universal_scanner.dm`: `/obj/item/universal_scanner/proc/export_scan`
- `code/modules/modular_computers/file_system/programs/budgetordering.dm`: `/datum/computer_file/program/budgetorders/ui_data`
- `code/modules/shuttle/mobile_port/variants/supply.dm`: `/obj/docking_port/mobile/supply/initiate_docking`, `/obj/docking_port/mobile/supply/proc/buy`, `/obj/docking_port/mobile/supply/proc/create_mail`

### Modular Overrides:

- `modular_zmixite/modules/cargo/code/shuttle.dm`: `/obj/docking_port/mobile/supply/sell`, `/obj/docking_port/mobile/supply/proc/get_purchase_turfs`
- `modular_zmixite/modules/cargo/code/orderconsole.dm`: `/obj/docking_port/mobile/supply/proc/get_purchase_turfs`, `/obj/machinery/computer/cargo/proc/create_requisition`, `/obj/machinery/computer/cargo/ui_act`
- `modular_zmixite/modules/cargo/code/sellconsole.dm`: `/obj/item/circuitboard/computer/cargo_seller`, `/obj/machinery/computer/cargo_seller` and its UI/export/sale procs
- `modular_zmixite/modules/cargo/code/markers.dm`: `/obj/effect/landmark/cargo_marker`, `/proc/get_cargo_marker_region`
- `modular_zmixite/modules/cargo/code/area.dm`: `/area/shared/ats`
- `modular_zmixite/modules/cargo/code/interdyne.dm`: Interdyne cargo console and its ordering procs
- `modular_zmixite/modules/cargo/code/loan_event.dm`: `/datum/round_event/shuttle_loan`
- `modular_zmixite/modules/cargo/code/modsuit.dm`: Loader MK2 MODsuit theme, outfit, and supply pack
- `modular_zmixite/modules/cargo/code/station_trait.dm`: `/datum/station_trait/ats`
- `modular_zmixite/master_files/code/modules/cargo/exports/crates.dm`: mail crate and goodie case exports
- `modular_zmixite/master_files/code/modules/modules_supply.dm`: cargo loader clamp capacity and loading speed
- `modular_zmixite/master_files/code/modules/shuttle/mobile_port/supply.dm`: cargo shuttle blacklist
- `modular_zmixite/master_files/code/modules/modular_computers/role_tablet_presets.dm`
- `modular_nova/modules/mapping/code/shuttles.dm`: Interdyne cargo shuttle destinations

### Defines:

- N/A

### Included files that are not contained in this module:

- `_maps/mixite/generic/RemoteCargo.dmm`
- `tgui/packages/tgui/interfaces/Cargo/CargoButtons.tsx`
- `tgui/packages/tgui/interfaces/Cargo/CargoCart.tsx`
- `tgui/packages/tgui/interfaces/Cargo/CargoStatus.tsx`
- `tgui/packages/tgui/interfaces/Cargo/types.ts`
- `tgui/packages/tgui/interfaces/CargoSeller.tsx`
