# claude-notifier: Play notification chime when Claude needs attention
# Only plays once per session to avoid spam

$sessionFile = "$env:TEMP\claude-notifier-session"

# If already played this session, exit
if (Test-Path $sessionFile) {
    exit 0
}

# Mark this session as having played
New-Item -Path $sessionFile -ItemType File -Force | Out-Null

# Play notification chime (ascending G major triad)
[System.Console]::Beep(784, 150)   # G5
Start-Sleep -Milliseconds 30
[System.Console]::Beep(988, 150)   # B5
Start-Sleep -Milliseconds 30
[System.Console]::Beep(1175, 200)  # D6
