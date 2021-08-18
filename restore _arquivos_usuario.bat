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

:: Questiona o nome do usuário
@set /p nome= Nome do Usuario:
@set /p user= Chave Linde:

:: Retornando arquivos do usuário.
@echo -----------------------------------------
@echo     Backup - Retornando arquivos
@echo -----------------------------------------
@robocopy "D:\backup\%nome%\user files" "C:\users\%user%" /r:1 /w:1 /e /eta
@ren c:\notes notesold
@robocopy "D:\backup\%nome%\c_raiz" C:\ /r:1 /w:1 /e /eta

:: Retornando Favoritos
@echo Restaurando favoritos do Chrome
@start Chrome
@taskkill /f /im chrome.exe
@xcopy  D:\backup\%nome%\Favoritos\Chrome\bookmarks "C:\users\%user%\AppData\Local\Google\Chrome\User Data\Default\" /e

@echo Restaurando favoritos do Edge
@start msedge
@taskkill /f /im msedge.exe
@xcopy  D:\backup\%nome%\Favoritos\Edge\bookmarks "C:\Users\%user%\AppData\Local\Microsoft\Edge\User Data\Default\" /e

:: Importando registros.
@ d:
@cd D:\backup\%nome%\registro
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
