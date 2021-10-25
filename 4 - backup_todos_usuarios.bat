@>nul chcp 65001
@pushd "%~dp0"
@chgcolor 02
@title Projeto WorkPlace - Parte 3 v2.0
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 3 v2.0
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
@echo ## ATENÇÃO - EXECUTAR COMO Admin Local ou do domínio PRAXAIR ##
@echo.
@net session >nul 2>&1
@if %errorLevel% == 0 (
    @chgcolor 27
    @echo Permissões administrativa confirmada.
    @echo.
    goto disco
) else (
        @chgcolor 46
        @echo SEM PERMISSÃO! ABRA NOVAMENTE COMO ADMINISTRADOR.
        echo.
        @chgcolor 07
        @timeout 3 /nobreak
        
        @echo.
        goto eof
)

:disco
@chgcolor 02
    @echo.
@echo ------------------------------------------------------------------------------
    @echo Discos conectados ao equipamento:
@echo ------------------------------------------------------------------------------
    @chgcolor 06
    @WMIC LOGICALDISK where drivetype=3 get deviceid,description
    @chgcolor 07
    @set /p letra= Letra do HD Externo: 
    @echo.
    @if exist %letra%:\ (
        @if exist %letra%:\Scripts\ (
        @goto HostName
        ) else (
            @chgcolor 46
            @echo Não é o HD Externo.
            @chgcolor 07
            @echo.
            @pause
            goto disco
        )
    ) else ( 
        @chgcolor 46
        @echo Esse disco não existe!
        @chgcolor 07
        @echo.
        @pause
        goto disco
    )
:HostName
@set /p nome= Hostname:
@echo.
@echo.
@echo ------------------------------------
@echo  Backup - Copiando arquivos
@echo ------------------------------------

:: Iniciando Caffeine64 para previnir que o Windows hiberne
@start %letra%:\Programas_Linde\caffeine64.exe -noicon

:: Copiando arquivos do usuario
@robocopy C:\users\ "%letra%:\backup\%nome%\user files" /r:1 /w:1 /e /eta /xd "all Users" "AdminTI" AppData "Local Settings" "Application Data"
@robocopy C:\ %letra%:\backup\%nome%\c_raiz /e /eta /r:1 /w:1 /XD "Program Files (x86)" Windows "Program Files" "Out-of-Box Drivers" Intel users Notes.old Notesold bginfo Perflogs ProgramData "Documents and Settings" $Recycle.Bin dell Config.msi Drivers 
attrib -h -s %letra%:\backup\%nome%\c_raiz

:: Exportando lista de programas instalados
@echo Exportando lista de softwares instalados.
wmic /OUTPUT:%letra%:\backup\%nome%\softwares_instalados.txt product get name, version
@cd \

:: Finalizando o Caffeine64
@taskkill /f /IM caffeine64.exe

@echo Finalizado! Verifique as pastas de destino e origem.

:: Abrindo pastas para comparação
@start explorer C:\
@start explorer "%letra%:\backup\%nome%\c_raiz"
@start explorer C:\users\%user%
@start explorer "%letra%:\backup\%nome%\user files"

@pause
@popd