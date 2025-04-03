# a functions module sourced in $PROFILE

function Set-RegistryValue {
    param (
        [string]$Path,
        [string]$Name,
        [string]$Value,
        [Microsoft.Win32.RegistryValueKind]$Type = [Microsoft.Win32.RegistryValueKind]::String
    )

    try {
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type
        Write-Host " Set $Name to '$Value' in $Path" -ForegroundColor Green
    } catch {
        Write-Host " Failed to update registry: $_" -ForegroundColor Red
    }
}
