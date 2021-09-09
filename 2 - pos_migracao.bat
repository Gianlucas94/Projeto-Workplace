@chcp 65001
@pushd "%~dp0"
@title Projeto WorkPlace - Parte 2 v2.0
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 2 v2.0
@echo ------------------------------------------------------------------------------
@echo .########.####.##.....##.####.########
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##...##...##...##.....##...
@echo ....##.....##....##.##....##.....##...
@echo ....##....####....###....####....##...
@color b
@echo ## ATENCAO - EXECUTAR APOS A INSTALACAO DA IMAGEM COM LOGIN ADMIN ##
@cd \

@net session >nul 2>&1
@if %errorLevel% == 0 (
    @echo Permiss√µes administrativa confirmada.
    @echo.
    goto inicio
) else (
        @echo SEM PERMISS√ÉO! ABRA NOVAMENTE COMO ADMINISTRADOR.
        @timeout 3 /nobreak
        goto eof
)

:inicio
@echo -------------------------------------------------------------
@echo Discos conectados ao equipamento:
@echo -------------------------------------------------------------
@WMIC LOGICALDISK where drivetype=3 get deviceid,description
@set /p letra= Letra do HD Externo: 
@echo.
@if exist %letra%:\ (
    @if exist %letra%:\Scripts\ (
        @goto posmigracao
    ) else (
        @echo N„o È o HD Externo.
        @timeout 3 /nobreak
        goto eof
        @start "" "%~f0"
    )
) else ( 
    @echo Esse disco n„o existe!
    @timeout 3 /nobreak
    goto eof
    @start "" "%~f0"
)

:posmigracao
:: Dando permiss√É¬£o para escrita no C:\
icacls "C:" /grant Everyone:M

:: Altera TimeZone
@echo Alterando Timezone...
@tzutil /s "E. South America Standard Time"
@echo.
@echo.

:: Instalando e restaurando programas.
echo ----------------------------------
@echo       Instalando softwares
echo ----------------------------------
@robocopy %letra%:\Programas_Linde\ c:\Temp /r:1 /w:1 /e
@echo.

@echo Instalando Chrome:
@start /w c:\Temp\ChromeSetup.exe
@taskkill /f /IM chrome.exe
@echo.

@echo Instalando Driver MaxxAudio:
@start /w c:\Temp\MaxxAudio.exe /s
@echo.

@echo Instalando notes
@start /w c:\Temp\Notes8.5.3\setuplocal.bat
@echo.
@echo -------------------------------------


@echo Finalizado.
@pause
@popd
