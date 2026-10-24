## Title: Cargo

MODULE ID: CARGO

### Description:

Cargo but you drive shuttle, viva la Space Station 14.

### TG Proc/File Changes:

- `code/modules/cargo/exports.dm`: `proc/export_item_and_contents`
- `code/modules/cargo/orderconsole.dm`: `/obj/machinery/computer/cargo/ui_act`
- `code/modules/shuttle/mobile_port/variants/supply.dm`: `/obj/docking_port/mobile/supply/proc/buy`, `/obj/docking_port/mobile/supply/proc/create_mail`

### Modular Overrides:

- `modular_zmixite/modules/cargo/code/shuttle.dm`: `/obj/docking_port/mobile/supply/sell`, `/obj/docking_port/mobile/supply/proc/get_purchase_turfs`
- `modular_zmixite/modules/cargo/code/orderconsole.dm`: `/obj/docking_port/mobile/supply/proc/get_purchase_turfs`, `/obj/machinery/computer/cargo/proc/create_requisition`, `/obj/machinery/computer/cargo/ui_act`
- `modular_zmixite/modules/cargo/code/sellconsole.dm`: `/obj/item/circuitboard/computer/cargo_seller`, `/obj/machinery/computer/cargo_seller` and its UI/export/sale procs
- `modular_zmixite/modules/cargo/code/markers.dm`: `/obj/effect/landmark/cargo_marker`, `/proc/get_cargo_marker_region`
- `modular_zmixite/master_files/code/modules/modular_computers/role_tablet_presets.dm`

### Defines:

- N/A

### Included files that are not contained in this module:

- `_maps/mixite/generic/RemoteCargo.dmm`
- `tgui/packages/tgui/interfaces/Cargo/CargoCart.tsx`
- `tgui/packages/tgui/interfaces/CargoSeller.tsx`
