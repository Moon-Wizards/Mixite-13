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

### Defines:

- N/A

### Included files that are not contained in this module:

- `_maps/mixite/generic/RemoteCargo.dmm`
- `tgui/packages/tgui/interfaces/Cargo/CargoCart.tsx`
- `tgui/packages/tgui/interfaces/CargoSeller.tsx`

---

### Hello People Internet

This is my segway into how I'm salty about a particular community which I certainly feel will steal this code for their own codebase (OCULIS STATION). Now you, the humble maintainer of this codebase, or you, the humble codediver reading this paragraph, may be asking:

> What's the use!?? What is the purpose!!?

The point of this document is to vent my disappointment regarding Oculis Station, the server that caused Mixite/13 to happen in the first place. I would love to still code for this place, or even be some bigger part of it, if I hadn't been pushed out, or if the administration wasn't straight-up horrendous. Banning people just because they don't like them and having secret admin "policies" that nobody even knows exist. Me writing this acknowledges that they have Mixite/13 on their radar and will probably snipe all the content they can just because, well, yes, it's GPL so they can legally do it. But I will be very unhappy and might relicense just because of it, if that actually turns out to be true.

Now, do I want to relicense from GPL to some weird fucking bullshit fork of the GPL just because of Oculis? No! But I want my work respected, especially since I was banned just for starting Mixite/13 (which is my assumption, but to this day they won't even tell me why, curious). They labeled me as some sort of name-calling satan, which... I'm sorry? Is your method of handling competition just shooting others down, Oculis? Because it certainly seems like it.

So, take this as a request for you to be original and not steal Mixite's content. I know you can be plenty original and make up some cool n' unique stuff for Oculis! But just imagine how shitty it makes you look to ban the underdog only to steal their content afterward. A very sad look for you clowns.

*PS: I am very open to a conversation either via a [comfortable contact](https://misleadingname.cc). Thank you!*

Toodles!<br>\- MisleadingName
