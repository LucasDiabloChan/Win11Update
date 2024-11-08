## Criadores:
# -> Lucas Mateus Braga de Souza
# -> Rafael Silva Perialdo
## Script para atualizar o Windows 11 Enterprise
## Data de criação: 05/11/2024

# Verificar se o script está sendo executado como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Este script precisa ser executado como administrador."
    exit
}

# Tenta importar o módulo de gerenciamento de atualização. 
# Caso não tenha, instala-o
try {
    Import-Module PSWindowsUpdate -ErrorAction Stop
} catch {
    Write-Host "Modulo PSWindowsUpdate nao encontrado. Instalando..."
    Install-Module PSWindowsUpdate -Force -Scope CurrentUser
    Import-Module PSWindowsUpdate
}

# Busca por atualizações disponíveis
Write-Host "Verificando atualizacoes disponiveis..."
$updates = Get-WindowsUpdate

if ($updates) {
    Write-Host "Atualizacoes encontradas: "
    $updates | Format-Table -Property KB, Title

    # Confirmar a instalação das atualizações
    do {
        $confirm = Read-Host "Deseja instalar as atualizacoes? (S/N)"
    } while ($confirm -ne "S" -and $confirm -ne "N")

    if ($confirm -eq "S") {
        Write-Host "Instalando atualizacoes..."
        try {
            Install-WindowsUpdate -AcceptAll -AutoReboot:$false -ErrorAction Stop
            Write-Host "Atualizacoes instaladas com sucesso!"
        } catch {
            Write-Host "Ocorreu um erro durante a instalacao das atualizacoes: $_"
        }

        # Perguntar sobre reinicialização
        $rebootConfirm = Read-Host "Deseja reiniciar o computador agora? (S/N)"
        if ($rebootConfirm -eq "S") {
            Restart-Computer
        } else {
            Write-Host "Reinicio adiado. Lembre-se de reiniciar o computador para aplicar as atualizacoes."
        }
    } else {
        Write-Host "Atualizaçoes nao foram instaladas."
    }
} else {
    Write-Host "Nenhuma atualizacao disponivel."
}

# Restaurar a política de execução original (personalizável)
$originalExecutionPolicy = Get-ExecutionPolicy
Set-ExecutionPolicy -ExecutionPolicy $originalExecutionPolicy -Scope Process -Force
