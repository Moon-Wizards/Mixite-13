# We follow [Nova's](/modular_nova/readme.md) modularization guidelines.

Slight notes:

- Instead of `NOVA ...` do `M13 ...`. (e.g. `M13 ADDITION START`)
- For new TGUI files, use `.tsx` not `.jsx`, and the comment should be `// THIS IS A MIXITE/13 UI FILE`
- Try not to make a brand new module for adding/changing one tiny thing, try to find an appropriate already existing mixite module beforehand, and work on it instead.
