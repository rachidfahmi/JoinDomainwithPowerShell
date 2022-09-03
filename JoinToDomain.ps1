###################################################################
#Script Name	:JoinToDomainusingPowerShell                                                                                            
#Description	:This script will joined a computer to domain.                                                                                 
#Args           :Computer Name                                                                                        
#Author       	:Rachid Fahmi                                               
#Email         	:rachid-fahmi@hotmial.com                                          
###################################################################


#force to request admin permission
param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

#allow script to be excuted

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

#request computer name
$name = read-host "computer new name  "

#Join domain with new name and reboot the machine
Add-Computer -DomainName gianttiger.com -NewName $name -Force -Restart
