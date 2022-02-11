SETLOCAL ENABLEDELAYEDEXPANSION
@>nul chcp 65001
@pushd "%~dp0"
@set PATH=%PATH%;"%~dp0lib"
@title Projeto WorkPlace - Parte 2 v2.0
@chgcolor 02
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 2 v2.0
@echo ------------------------------------------------------------------------------
@chgcolor 04
@echo .########.####.##.....##.####.########
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##...##...##...##.....##...
@echo ....##.....##....##.##....##.....##...
@echo ....##....####....###....####....##...
@echo.
@chgcolor 46
@echo ## ATENCÃO - EXECUTAR APÓS A INSTALAÇÃO DA IMAGEM COM LOGIN ADMIN ##
@echo.

:: Pegar modelo do equipamento e setar em variaveis
@for /F "skip=1 tokens=*" %%f in ('wmic CSPRODUCT get NAME ^| findstr /V /R "^$"') do @set modelo=%%f
@for /f "tokens=1,2 delims= " %%a in ("%modelo%") do @set tipo=%%a&set modelo=%%b

@net session >nul 2>&1
@if %errorLevel% == 0 (
    @chgcolor 27
    @echo Permissões administrativa confirmada.
    @echo.
    goto inicio
) else (
        @chgcolor 46
        @echo SEM PERMISSÃO! ABRA NOVAMENTE COMO ADMINISTRADOR.
        echo.
        @chgcolor 07
        @timeout 3 /nobreak
        
        @echo.
        goto eof
)

:inicio
@chgcolor 02
@echo ------------------------------------------------------------------------------
@echo Discos conectados ao equipamento:
@echo ------------------------------------------------------------------------------
@chgcolor 06
@WMIC LOGICALDISK where drivetype=3 get deviceid,description
@set /p letra= Letra do HD Externo: 
@echo.
@if exist %letra%:\ (
    @if exist %letra%:\Scripts\ (
        @goto posmigracao
    ) else (
        @chgcolor 46
        @echo Não é o HD Externo.
        @chgcolor 07
        @pause
        @echo.
        goto inicio
    )
) else ( 
    @chgcolor 46
    @echo Esse disco não existe!
    @chgcolor 07
    @pause
    @echo.
    goto inicio
)

:posmigracao
:: Dando permissÃ£o para escrita no C:\
@icacls "C:/" /grant Everyone:F
@icacls "C:/" /grant Users:F


:: Altera TimeZone
@echo Alterando Timezone...
@tzutil /s "E. South America Standard Time"
@echo.
@echo.

:: Fix para instalação de impressora
@echo Fix para instalação de impressoras.
@reg import %~dp0fixes\regs\Printer_Install.reg
@echo.

:drivers
:: Atualizando Drivers e Bios
@chgcolor 06
@set /p driver= "Deseja instalar os Drivers (S | n) ? "
@if /i "%driver%"=="s" (
    @echo.
    @echo Instalando Drivers para o modelo %tipo% %modelo%
    cd %~dp0drivers\%tipo%\%modelo%
    for /r %%f in (*.exe) do (start /wait %%f /s)

    @set /p bios= "Deseja atualizar a BIOS (S | n) ? "
    @if /i "%bios%"=="s" (
        cd %~dp0drivers\%tipo%\%modelo%\bios
        for /r %%f in (*.exe) do (@start /wait %%f /s)
        cd %~dp0
    )
) 
        pause        
) else (
        @echo Opção inválida! 
        @pause
        @echo.
        goto drivers
    )
 @if /i "%driver%"=="n" (
     @echo.
     @goto softwares
 )

:softwares
:: Instalando e restaurando programas.
@chgcolor 02
@echo ------------------------------------------------------------------------------
@echo       Instalando softwares
@echo ------------------------------------------------------------------------------
@chgcolor 07
@robocopy %letra%:\Programas_Linde\ c:\Temp /r:1 /w:1 /e
@echo.

@echo Instalando Chrome:
@start /w c:\Temp\ChromeSetup.exe
@taskkill /f /IM chrome.exe
@echo.

@echo Instalando Driver MaxxAudio:
@start /w c:\Temp\MaxxAudio.exe /s
@echo.

@echo Instalando Sensor CrowdStrike:
@start /w C:\temp\WindowsSensor_6.16\WindowsSensor.exe /install /passive /norestart CID=0A5B1B6C97734FF7801837C1D1070336-23 PACURL=http://pac.linde.grp/crowdstrike.pac
@echo.

@echo Instalando Lotus Notes:
@start /b /w c:\Temp\Notes8.5.3\setuplocal.bat
@echo.


@echo ------------------------------------------------------------------------------

@echo Finalizado.
@pause
@popd