## Title: Automapper

MODULE ID: AUTOMAPPER

### Description:

Automapper additions let map-specific modules place small `.dmm` templates onto existing automapped maps without maintaining a separate full-map fork.

The module adds a second automapper configuration alongside Nova's configuration and supports templates attached to ruins.

### Configuration:

Templates are registered in:

- `_maps/mixite/automapper/automapper_config.toml`

Each template entry provides:

- `map_files`: One or more `.dmm` files to choose from.
- `directory`: The directory containing those map files.
- `required_map`: The map or ruin filename the template belongs to.
- `coordinates`: `[x, y, z]` placement coordinates.
- `trait_name`: The z-level trait used for normal map placement.

For templates attached to a ruin, coordinates are relative to the ruin's bottom-left corner. The z coordinate is relative to the ruin's z-level. For ordinary map templates, the z coordinate indexes the selected trait's z-level list rather than being used as a raw world z value.

### TG Proc/File Changes:

- `code/modules/atmospherics/machinery/atmosmachinery.dm`: `/obj/machinery/atmospherics/proc/disconnect`

### Modular Overrides:

- `modular_zmixite/modules/automapper/code/automapper.dm`: config loading, template preloading, and ruin template loading

### Defines:

- N/A

### Included files that are not contained in this module:

- N/A

### Runtime notes:

Ruin templates are deferred until `SSspatial_grid` has initialized. Loading atmos machinery before the spatial grid exists causes grid lookups to fall over spectacularly, so the automapper waits one tick when necessary.

Existing objects are removed before the replacement template is initialized. This matters for atmos machinery: pipelines need to disconnect cleanly before their replacements arrive, or stale references begin doing exciting things to the runtime log.

### Credits:

- [@misleadingname]: Module code.
- [@Gandalf2k15]: Original Nova automapper module.
