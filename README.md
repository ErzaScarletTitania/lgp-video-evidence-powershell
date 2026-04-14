# g-connect-frame-extractor-ps1

PowerShell helper extracted from the G-Connect testing session workspace.

## Purpose

This script samples a recorded test-session video at fixed timestamps and writes PNG frames that can be reviewed as evidence snapshots.

## Current behavior

- Uses WPF media playback from PowerShell
- Reads a specific recorded SiPass session video
- Exports frames at 30-second intervals
- Writes PNG files into the Copilot session workspace

## Notes

- The current script preserves the original session-specific absolute paths exactly as used during the test work.
- It was split out into its own repository without rebuilding or redesigning the code.

## Main file

- `extract-video-frames.ps1`
