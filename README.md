# LGP Video Evidence - PowerShell

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

## Related projects

- [LGP Video Evidence - C#](https://github.com/ErzaScarletTitania/lgp-video-evidence-csharp): an alternative frame-extraction implementation using OpenCvSharp.
- [LGP QA Orchestration](https://github.com/ErzaScarletTitania/lgp-qa-orchestration): a related architecture reference for evidence-based QA workflows.

These are related projects, not package dependencies. This extractor keeps its own runtime and setup requirements.
