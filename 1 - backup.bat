@chcp 65001
@pushd "%~dp0"
@title Projeto WorkPlace - Parte 1 v.2.0
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 1 v.2.0
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
@echo ## ATENCAO - EXECUTAR COM O USUARIO LOGADO NO DOMINIO PRAXAIR##
@echo.

:disco
    @echo -------------------------------------------------------------
    @echo Discos conectados ao equipamento:
    @echo -------------------------------------------------------------
    @WMIC LOGICALDISK where drivetype=3 get deviceid,description
    @set /p letra= Letra do HD Externo: 
    @echo.
    @if exist %letra%:\ (
        @if exist %letra%:\Scripts\ (
            @goto nome
        ) else (
            @echo Não é o HD Externo.
            @echo.
            @timeout 3 /nobreak
            goto disco
        )
    ) else ( 
        @echo Esse disco não existe!
        @echo.
        @timeout 3 /nobreak
        goto disco
    )

:nome
    @set /p nome= Nome do Usuario (Sem espaços): 
    @echo.

:chave
    @set /p user= Chave Praxair: 
    @echo.
    @if exist c:\users\%user%\ (
        goto backup
    ) else (
            @echo Perfil do usuário não encontrado! Verifique os perfis que estão na máquina abaixo e tente novamente:
            @echo.
            @for /F "usebackq" %%i IN (`dir c:\users /b ^| sort`) DO @echo %%i
            @echo.
            @pause
            goto chave
    )

:backup
@echo.
@echo ------------------------------------
@echo  Backup - Copiando arquivos
@echo ------------------------------------
@echo.

:: Iniciando Caffeine64 para previnir que o Windows hiberne
@start %letra%:\Programas_Linde\caffeine64.exe -noicon

:: Copiando arquivos do usuario
@echo Backup perfil do usuário >> %letra%:\backup\%nome%\logs\log_backup.txt
@choice.exe /c sn /m "Deseja fazer backup do OneDrive?"
    @if errorlevel 1 do @robocopy C:\users\%user% "%letra%:\backup\%nome%\user files" /r:1 /w:1 /e /eta /xd C:\users\%user%\AppData "C:\users\%user%\Local Settings" "Application Data" /log:%letra%:\backup\%nome%\logs\log_backup.txt
    @if errorlevel 2 do @robocopy C:\users\%user% "%letra%:\backup\%nome%\user files" /r:1 /w:1 /e /eta /xd C:\users\%user%\AppData "C:\users\%user%\Local Settings" onedrive "Application Data" /log:%letra%:\backup\%nome%\logs\log_backup.txt
@echo Backup C:\ >> %letra%:\backup\%nome%\logs\log_backup.txt
    @robocopy C:\ %letra%:\backup\%nome%\c_raiz /e /eta /r:1 /w:1 /XD "Program Files (x86)" Windows "Program Files" "Out-of-Box Drivers" Intel users Notes.old Notesold bginfo Perflogs ProgramData "Documents and Settings" $Recycle.Bin dell Config.msi Drivers  /log+:%letra%:\backup\%nome%\logs\log_backup.txt
@echo Backup favoritos Chrome/Edge >> %letra%:\backup\%nome%\logs\log_backup.txt
    @echo d|xcopy "C:\users\%user%\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" %letra%:\backup\%nome%\Favoritos\Chrome /i >> %letra%:\backup\%nome%\logs\log_backup.txt
    @echo d|xcopy "C:\users\%user%\AppData\Local\Microsoft\Edge\User Data\Default\Bookmarks" %letra%:\backup\%nome%\Favoritos\Edge /i >> %letra%:\backup\%nome%\logs\log_backup.txt
@attrib -h -s %letra%:\backup\%nome%\c_raiz

:: Criando pastas e exportando registros
@ %letra%:
@cd %letra%:\backup\%nome%
@mkdir registro
@mkdir logs
@cd %letra%:\backup\%nome%\registro
@echo --------------------------------------------------------------------------
@echo        Impressoras e mapeamentos - Exportando chaves do registro
@echo ---------------------------------------------------------------------------
@echo Registros exportados >> %letra%:\backup\%nome%\logs\log_backup.txt
@reg export "HKEY_CURRENT_USER\Network" mapeamento.reg /y >> %letra%:\backup\%nome%\logs\log_backup.txt
@reg export "HKEY_CURRENT_USER\Printers" impressoras.reg /y >> %letra%:\backup\%nome%\logs\log_backup.txt

:: Exportando lista de programas instalados
@echo Exportando lista de softwares instalados.
wmic /OUTPUT:%letra%:\backup\%nome%\logs\softwares_instalados.txt product get name, version
@cd \

:: Exportando Logs
hostname >> %letra%:\backup\%nome%\logs\log_backup.txt
@echo -------------------------------------------- >> %letra%:\backup\%nome%\logs\log_backup.txt
@echo                Tamanho das pastas            >> %letra%:\backup\%nome%\logs\log_backup.txt
@echo -------------------------------------------- >> %letra%:\backup\%nome%\logs\log_backup.txt
@echo. >> %letra%:\backup\%nome%\logs\log_backup.txt
@cd c:\users\%user%\ >> %letra%:\backup\%nome%\logs\log_backup.txt
    cd >> %letra%:\backup\%nome%\logs\log_backup.txt
%letra%:\backup\%nome%\Programas_Linde\du.exe c:\users\%user%\ >> %letra%:\backup\%nome%\logs\log_backup.txt
@cd c:\Notes >> %letra%:\backup\%nome%\logs\log_backup.txt
    cd >> %letra%:\backup\%nome%\logs\log_backup.txt
%letra%:\backup\%nome%\Programas_Linde\du.exe c:\users\notes\ >> %letra%:\backup\%nome%\logs\log_backup.txt

::hostname >> %letra%:\backup\%nome%\logs\log_backup.txt
@cd "%letra%:\backup\%nome%\user files"
    cd >> %letra%:\backup\%nome%\logs\log_backup.txt
%letra%:\backup\%nome%\Programas_Linde\du.exe "%letra%:\backup\%nome%\user files" >> %letra%:\backup\%nome%\logs\log_backup.txt
@cd %letra%:\backup\%nome%\c_raiz\Notes
    cd >> %letra%:\backup\%nome%\logs\log_backup.txt
%letra%:\backup\%nome%\Programas_Linde\du.exe %letra%:\backup\%nome%\c_raiz\Notes >> %letra%:\backup\%nome%\logs\log_backup.txt


:: Finalizando o Caffeine64
@taskkill /f /IM caffeine64.exe

@echo Finalizado! Verifique logs e as pastas de destino e origem.

:: Abrindo logs
@explorer %letra%:\backup\%nome%\logs

@pause
@popd

