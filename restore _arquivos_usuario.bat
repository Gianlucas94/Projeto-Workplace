@pushd "%~dp0"
@title Projeto WorkPlace - Parte 3 v1.6
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 3 v1.6
@echo ------------------------------------------------------------------------------
@echo .########.####.##.....##.####.########
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##...##...##...##.....##...
@echo ....##.....##....##.##....##.....##...
@echo ....##....####....###....####....##...
@color b
@echo ## ATENCAO - EXECUTAR COM O USUARIO LOGADO ##
@cd \

:: Questiona o nome do usuário e letra do HD
@set /p letra= Letra do HD Externo:
@echo.
@set /p nome= Nome do Usuario:
@echo.
@set /p user= Chave Linde:
@echo.

:: Retornando arquivos do usuário.
@echo -----------------------------------------
@echo     Backup - Retornando arquivos
@echo -----------------------------------------
@robocopy "%letra%:\backup\%nome%\user files" "C:\users\%user%" /r:1 /w:1 /e /eta
@ren c:\notes notesold
@robocopy "%letra%:\backup\%nome%\c_raiz" C:\ /r:1 /w:1 /e /eta

:: Retornando Favoritos
@echo Restaurando favoritos do Chrome
@start Chrome
@taskkill /f /im chrome.exe
@xcopy  %letra%:\backup\%nome%\Favoritos\Chrome\bookmarks "C:\users\%user%\AppData\Local\Google\Chrome\User Data\Default\" /e

@echo Restaurando favoritos do Edge
@start msedge
@taskkill /f /im msedge.exe
@xcopy  %letra%:\backup\%nome%\Favoritos\Edge\bookmarks "C:\Users\%user%\AppData\Local\Microsoft\Edge\User Data\Default\" /e

:: Importando registros.
@ d:
@cd %letra%:\backup\%nome%\registro
@echo --------------------------------------------------------------------------
@echo  Impressoras e mapeamentos - Importando chaves do registro
@echo ---------------------------------------------------------------------------
@reg import mapeamento.reg
@reg import impressoras.reg
@cd \
:: Alterando Página Inicial
@echo y|REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /V "Start Page" /D "portalwm.sa.praxair.com" /F
@echo ----------------------------
@echo Finalizado.
@pause
@popd
