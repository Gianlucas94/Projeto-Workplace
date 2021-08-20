@pushd "%~dp0"
@title Projeto WorkPlace - Parte 1 v.1.6
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 1 v.1.6
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
@echo ## ATENCAO - EXECUTAR COM O USUARIO LOGADO ##

@set /p letra= Letra do HD Externo:
@echo.
@set /p nome= Nome do Usuario:
@echo.
@set /p user= Chave Praxair: 
@echo.
@echo ------------------------------------
@echo  Backup - Copiando arquivos
@echo ------------------------------------

:: Copiando arquivos do usuario
@robocopy C:\users\%user% "%letra%:\backup\%nome%\user files" /r:1 /w:1 /e /eta /xd C:\users\%user%\AppData "C:\users\%user%\Local Settings" "Application Data"
@echo d|xcopy "C:\users\%user%\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" %letra%:\backup\%nome%\Favoritos\Chrome /i
@echo d|xcopy "C:\users\%user%\AppData\Local\Microsoft\Edge\User Data\Default\Bookmarks" %letra%:\backup\%nome%\Favoritos\Edge /i
::@echo d|xcopy C:\ %letra%:\backup\%nome%\c_raiz /e /y /EXCLUDE:%letra%:\Scripts\Excluded.txt
@robocopy C:\ %letra%:\backup\%nome%\c_raiz /e /eta /r:1 /w:1 /XD "Program Files (x86)" Windows "Program Files" "Out-of-Box Drivers" Intel users Notes.old Notesold bginfo Perflogs ProgramData "Documents and Settings" $Recycle.Bin dell Config.msi Drivers 
attrib -h -s %letra%:\backup\%nome%\c_raiz

:: Criando pastas e exportando registros
@ %letra%:
@cd %letra%:\backup\%nome%
@mkdir registro
@cd %letra%:\backup\%nome%\registro
@echo --------------------------------------------------------------------------
@echo        Impressoras e mapeamentos - Exportando chaves do registro
@echo ---------------------------------------------------------------------------
@reg export "HKEY_CURRENT_USER\Network" mapeamento.reg /y
@reg export "HKEY_CURRENT_USER\Printers" impressoras.reg /y

:: Exportando lista de programas instalados
@echo Exportando lista de softwares instalados.
wmic /OUTPUT:%letra%:\backup\%nome%\softwares_instalados.txt product get name, version
@cd \
@echo Finalizado! Verifique as pastas de destino e origem.

@start explorer C:\
@start explorer "%letra%:\backup\%nome%\c_raiz"
@start explorer C:\users\%user%
@start explorer "%letra%:\backup\%nome%\user files"
@pause
@popd
