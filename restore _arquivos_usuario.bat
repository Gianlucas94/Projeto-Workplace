@pushd "%~dp0"
@title Projeto WorkPlace - Parte 3 v1.4
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 3 v1.4
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
@echo restaurando Favoritos do Chrome
@start Chrome
@taskkill /f /im chrome.exe
@xcopy  D:\backup\%nome%\Favoritos\bookmarks "C:\users\%user%\AppData\Local\Google\Chrome\User Data\Default\" /e

:: Importando registros.
@ d:
@cd D:\backup\%nome%\registro
@echo --------------------------------------------------------------------------
@echo  Impressoras e mapeamentos - Importando chaves do registro
@echo ---------------------------------------------------------------------------
@reg import mapeamento.reg
@reg import impressoras.reg
@cd \
@echo ----------------------------
@echo Finalizado.
@pause
@popd
