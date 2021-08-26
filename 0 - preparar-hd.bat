@pushd "%~dp0"
@title Projeto WorkPlace - Parte 0 v.1.9.1
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 0 v.1.9.1
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
@set /p letra= Letra do HD Externo:
@echo ------------------------------------
@echo  Backup - Copiando instaladores
@echo ------------------------------------


:: Verifica se hÃ¡ scripts e instaladores antigos
@echo Atualizando scripts e instaladores
@del "%letra%:\scripts" /s /q
@del "%letra%:\Programas_Linde" /s /q

:: Copiando instaladores para o HD Externo
@robocopy \\brariofs01\transfer\Gian %letra%:\ /r:1 /w:1 /e /eta
