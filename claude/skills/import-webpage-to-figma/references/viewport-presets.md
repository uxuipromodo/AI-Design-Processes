# Viewport presets reference

- Purpose:
- Provide standard viewport interpretations when users request desktop or mobile captures without specifying exact sizes.

## Desktop presets

- Desktop → 1440 default
- Large Desktop → 1920
- Laptop → 1366
- Small Desktop → 1280
- If the user explicitly specifies a width, always use that instead of presets.

## Mobile presets

- Mobile → 390 default
- iPhone Small → 375
- Android → 360
- Large Mobile → 430
- If multiple mobile sizes are requested, treat each as a separate capture frame.

## Tablet presets

- Tablet → 768
- Large Tablet → 1024
- Tablet capture is optional and only executed if explicitly requested.

## Height handling rule

- If viewport height is not specified:
- Use a reasonable default capture height sufficient for layout stabilization before Figma import.
- Do not invent alternative widths.
