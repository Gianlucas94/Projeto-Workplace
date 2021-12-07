@>nul chcp 65001
@pushd "%~dp0"
@setlocal EnableDelayedExpansion
@title Projeto WorkPlace - Parte 0 v.2.0
@echo off
chgcolor 02
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 0 v.2.0
@echo ------------------------------------------------------------------------------
chgcolor 04
@echo .########.####.##.....##.####.########
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##...##...##...##.....##...
@echo ....##.....##....##.##....##.....##...
@echo ....##....####....###....####....##...
@echo. 
chgcolor 46
@echo ## ATENCAO - EXECUTAR LOGADO NO DOMÍNIO PRAXAIR ##
@echo.
@echo ## ATENCAO - BAT PARA PREPARAR HD EXTERNO PARA USO DAS BATS DO PROJETO WORKPLACE ##
@echo.
chgcolor 02
@echo ------------------------------------------------------------------------------
@echo Discos conectados ao equipamento:
@echo ------------------------------------------------------------------------------
chgcolor 07
:HD
chgcolor 06
@WMIC LOGICALDISK where drivetype=3 get deviceid,description
@echo.
chgcolor 07
@set /p letra= Letra do HD Externo: 
@echo.
@if exist %letra%:\ (
    goto preparar
) else (
    @chgcolor 46
    @echo Esse disco não existe!
    chgcolor 7
    @echo.
    @pause
    @echo.
    goto HD
)

:preparar
chgcolor 02
@echo ------------------------------------------------------------------------------
@echo  Backup - Copiando instaladores
@echo ------------------------------------------------------------------------------
:: Verifica se há scripts e instaladores antigos
chgcolor 06
@echo Atualizando scripts e instaladores
chgcolor 07
@if exist %letra%:\scripts (
    @del "%letra%:\scripts" /s /q
    )
@if exist %letra%:\Programas_Linde (
    @del "%letra%:\Programas_Linde" /s /q
)

reg %~dp0\import Printer_Install.reg

