# --- CONFIGURATION ---
# Path to your Git folder (Change this!)
$repoPath = "C:\Users\canoscaliskan\Documents\GitHub\References"
# Name of your bib file
$bibFile = "literatur.bib"
# ---------------------

# Navigate to the folder
Set-Location $repoPath

Write-Host "Target: $bibFile"
Write-Host "Status: Watching for Zotero updates..." -ForegroundColor Cyan

# Get the initial timestamp of the file
$lastTimestamp = (Get-Item $bibFile).LastWriteTime

while ($true) {
    # Check every 3 seconds
    Start-Sleep -Seconds 3
    
    # Get current timestamp
    $currentTimestamp = (Get-Item $bibFile).LastWriteTime

    # Compare timestamps
    if ($currentTimestamp -ne $lastTimestamp) {
        Write-Host "Update detected! Syncing to GitHub..." -ForegroundColor Yellow
        
        try {
            # Git Commands
            git add $bibFile
            git commit -m "Auto-update references: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
            git push
            
            Write-Host "Success: Pushed to GitHub." -ForegroundColor Green
        }
        catch {
            Write-Host "Error: Git push failed." -ForegroundColor Red
        }

        # Update the timestamp so we don't push again until next change
        $lastTimestamp = $currentTimestamp
    }
}