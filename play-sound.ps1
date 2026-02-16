# claude-notifier: Play notification beep when Claude needs attention

# Notification chime pattern
[System.Console]::Beep(784, 150)   # G5
Start-Sleep -Milliseconds 30
[System.Console]::Beep(988, 150)   # B5
Start-Sleep -Milliseconds 30
[System.Console]::Beep(1175, 200)  # D6
