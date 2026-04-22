# State capture reference

- Purpose:
- Define supported UI states that can be captured before importing a webpage into Figma.

## Default state

- Definition:
- Page captured after load stabilization without additional interaction.
- Alias interpretations:
- default
- initial
- page loaded
- normal state

## Overlay states

- Definition:
- States requiring user-triggered UI interaction before capture.
- Supported overlay types:
- Mobile menu
- Desktop menu
- Filters panel
- Dropdown
- Modal
- Popup
- Drawer
- Search panel

## Interaction-triggered states

- Definition:
- States activated through explicit interaction before capture.
- Examples:
- menu open
- filters open
- modal open
- dropdown expanded
- search opened

## Capture eligibility rule

- Only capture overlay states explicitly requested by the user.
- Do not infer additional states automatically.

## Multi-state capture rule

- If multiple states are requested:
- Each state must be captured as a separate Figma frame.
- Example interpretations:
- Mobile default
- Mobile menu open
- Desktop filters open
- Desktop dropdown expanded
