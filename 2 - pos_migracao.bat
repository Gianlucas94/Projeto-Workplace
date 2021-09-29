@>nul chcp 65001
@pushd "%~dp0"
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

@echo Instalando Lotus Notes:
@start /w c:\Temp\Notes8.5.3\setuplocal.bat
@echo.
@echo ------------------------------------------------------------------------------
exit /b

@echo Finalizado.
@pause
@popd
