https://github.com/Moon-Wizards/Mixite-13/pulls

## Screen Vote

MODULE ID: SCREEN_VOTE

### Description:

Shows the currently running vote as a screen HUD element in the top-right of the
screen instead of requiring players to open the vote TGUI.

### TG Proc Changes:

- `code/_onclick/hud/hud.dm`
  - `/datum/hud/New`: adds the `mapvote_hud` screen object when the
    `mapvote_hud` preference is enabled
- `code/controllers/subsystem/vote.dm`
  - `SSvote` sends `COMSIG_VOTE_STARTED` when a vote starts and
    `COMSIG_VOTE_ENDED` when a vote finishes

### Defines:

- `code/__DEFINES/~zmixite_defines/hud.dm`: `UI_VOTEHUD`,
  `UI_VOTEHUD_LEFT`, `HUD_MAPVOTE`
- `code/__DEFINES/~zmixite_defines/dcs/signals.dm`: `COMSIG_VOTE_STARTED`,
  `COMSIG_VOTE_ENDED`, `COMSIG_VOTE_CHOICE_SELECTED`

### Master file additions

- N/A

### Included files that are not contained in this module:

- `code/_onclick/hud/hud.dm`
- `code/controllers/subsystem/vote.dm`
- `code/__DEFINES/~zmixite_defines/hud.dm`
- `code/__DEFINES/~zmixite_defines/dcs/signals.dm`
- `tgui/packages/tgui/interfaces/PreferencesMenu/preferences/features/game_preferences/zmixite/screen_vote.tsx`

### Credits

- Bubberstation
