@chcp 65001
@pushd "%~dp0"
@title Projeto WorkPlace - Parte 0 v.2.0
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 0 v.2.0
@echo ------------------------------------------------------------------------------
@color b
@echo .########.####.##.....##.####.########
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##...##...##...##.....##...
@echo ....##.....##....##.##....##.....##...
@echo ....##....####....###....####....##...
@echo. 
@cd \
@echo ## ATENCAO - EXECUTAR LOGADO NO DOMINIO PRAXAIR ##
@echo ## ATENCAO - BAT PARA PREPARAR HD EXTERNO PARA USO DAS BATS DO PROJETO WORKPLACE ##
@echo.
@echo -------------------------------------------------------------
@echo Discos conectados ao equipamento:
@echo -------------------------------------------------------------
@WMIC LOGICALDISK where drivetype=3 get deviceid,description
@echo.
@set /p letra= Letra do HD Externo: 
@echo.
@if exist %letra%:\ (
    goto preparar
) else (
    @echo Esse disco não existe!
    @timeout 3 /nobreak
    goto eof
    @start "" "%~f0"
)

:preparar
@echo ------------------------------------
@echo  Backup - Copiando instaladores
@echo ------------------------------------
:: Verifica se hÃ¡ scripts e instaladores antigos
@echo Atualizando scripts e instaladores

@if exist %letra%:\scripts (
    @del "%letra%:\scripts" /s /q
    )
@if exist %letra%:\Programas_Linde (
    @del "%letra%:\Programas_Linde" /s /q
)

:: Copiando instaladores para o HD Externo
@robocopy \\brariofs01\transfer\Gian %letra%:\ /r:1 /w:1 /e /eta
