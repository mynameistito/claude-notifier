# claude-notifier

A lightweight Windows utility that plays audible notifications when Claude Code needs your attention. Uses a 3-note console beep chime — no external dependencies or sound files required.

**Platform:** Windows | **License:** [MIT](LICENSE)

## How it works

Uses [Claude Code hooks](https://docs.anthropic.com/en/docs/claude-code/hooks) to trigger an audible chime when:
- Claude asks you a question (`Notification` hook)
- Claude finishes a task and waits for input (`Stop` hook)

The chime is generated with `[System.Console]::Beep()` in PowerShell, producing a short ascending 3-note pattern.

## Files

| File | Purpose |
|---|---|
| `play-sound.ps1` | PowerShell script that plays the 3-note chime |
| `settings.json` | Claude Code hook configuration (copy into `~/.claude/settings.json`) |
| `LICENSE` | MIT License |

## Setup

1. Clone or download this repo somewhere on your system
2. Merge the hooks from `settings.json` into your `~/.claude/settings.json`, updating the path to where you placed `play-sound.ps1`:

```json
{
  "hooks": {
    "Notification": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "powershell -NoProfile -ExecutionPolicy Bypass -File \"C:\\path\\to\\play-sound.ps1\"",
            "timeout": 10
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "powershell -NoProfile -ExecutionPolicy Bypass -File \"C:\\path\\to\\play-sound.ps1\"",
            "timeout": 10
          }
        ]
      }
    ]
  }
}
```

## Customization

Edit `play-sound.ps1` to change the chime. Each line follows this format:

```powershell
[System.Console]::Beep(frequency, duration)
```

- **frequency** — pitch in Hz (37–32767)
- **duration** — how long the note plays in milliseconds
- **`Start-Sleep -Milliseconds`** — pause between notes

### Note reference

| Note | Hz | Note | Hz | Note | Hz |
|---|---|---|---|---|---|
| C4 | 262 | C5 | 523 | C6 | 1047 |
| D4 | 294 | D5 | 587 | D6 | 1175 |
| E4 | 330 | E5 | 659 | E6 | 1319 |
| F4 | 349 | F5 | 698 | F6 | 1397 |
| G4 | 392 | G5 | 784 | G6 | 1568 |
| A4 | 440 | A5 | 880 | A6 | 1760 |
| B4 | 494 | B5 | 988 | B6 | 1976 |

### Example chimes

**Default (ascending G major triad):**

```powershell
[System.Console]::Beep(784, 150)   # G5
Start-Sleep -Milliseconds 30
[System.Console]::Beep(988, 150)   # B5
Start-Sleep -Milliseconds 30
[System.Console]::Beep(1175, 200)  # D6
```

**Simple two-tone alert:**

```powershell
[System.Console]::Beep(880, 200)   # A5
Start-Sleep -Milliseconds 50
[System.Console]::Beep(1760, 300)  # A6
```

**Descending chime:**

```powershell
[System.Console]::Beep(1319, 150)  # E6
Start-Sleep -Milliseconds 30
[System.Console]::Beep(988, 150)   # B5
Start-Sleep -Milliseconds 30
[System.Console]::Beep(784, 200)   # G5
```

**Single long beep:**

```powershell
[System.Console]::Beep(1047, 500)  # C6
```

### Playing a WAV file instead

To play a system or custom WAV file instead of console beeps, replace the contents of `play-sound.ps1` with:

```powershell
$player = New-Object System.Media.SoundPlayer
$player.SoundLocation = "$env:WINDIR\Media\Windows Notify.wav"
$player.Load()
$player.PlaySync()
```

Common Windows system sounds (found in `C:\Windows\Media\`):

| File | Sound |
|---|---|
| `Windows Notify.wav` | Subtle notification |
| `Windows Exclamation.wav` | Attention/warning |
| `Windows Critical Stop.wav` | Error/critical alert |
| `chimes.wav` | Classic chime |
| `tada.wav` | Completion fanfare |
| `Ring10.wav` | Phone-style ring |

You can also point `SoundLocation` to any `.wav` file on your system.

## Requirements

- Windows (uses `[System.Console]::Beep()` which is Windows-only)
- PowerShell (ships with Windows)
- Claude Code with hooks support

## License

This project is open source under the [MIT License](LICENSE).
