@chcp 65001
@pushd "%~dp0"
@title Projeto WorkPlace - Parte 3 v2.0
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 3 v2.0
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

:disco
    @echo.
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
            @echo N„o È o HD Externo.
            @echo.
            @timeout 3 /nobreak
            goto disco
        )
    ) else ( 
        @echo Esse disco n„o existe!
        @echo.
        @timeout 3 /nobreak
        goto disco
    )
:nome
    @set /p nome= Nome do Usuario: 
    @echo.
        @if exist %letra%:\backup\%nome% (
            goto chave
        ) else (
            @echo N„o h· esse nome no backup! verifique o nome abaixo e tente novamente:
            @echo.
            @for /F "usebackq" %%i IN (`dir %letra%:\backup\ /b ^| sort`) DO @echo %%i
            @echo.
            @pause
            goto nome
        )
:chave
    @set /p user= Chave Linde: 
    @echo.
        @if exist c:\users\%user% (
            goto restore
        ) else (
            @echo Perfil do usu·rio n„o encontrado! Verifique os perfis que est„o na m·quina abaixo e tente novamente:
            @echo.
            @for /F "usebackq" %%i IN (`dir c:\users\ /b ^| sort`) DO @echo %%i
            @echo.
            @pause
            goto chave
            ) 
)
  

:restore
:: Iniciando Caffeine para previnir que o Windows hiberne.
@start c:\temp\caffeine64.exe -noicon

:: Retornando arquivos do usu√°rio.
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
@ %letra%:
@cd %letra%:\backup\%nome%\registro
@echo --------------------------------------------------------------------------
@echo  Impressoras e mapeamentos - Importando chaves do registro
@echo --------------------------------------------------------------------------
@reg import mapeamento.reg
@reg import impressoras.reg
@cd \

:: Alterando P√°gina Inicial do Internet Explorer
@echo Alterando P·gina inicial do internet Explorer
@echo y|REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /V "Start Page" /D "portalwm.sa.praxair.com" /F

@echo Fixando Ìcones na barra de tarefa
c:\temp\syspin.exe "%programfiles%\internet explorer\iexplore.exe" 5386
c:\temp\syspin.exe "C:\Program files (x86)\Microsoft Office\root\Office16\OUTLOOK.exe" 5386

:: Finalizando o Caffeine64
@taskkill /f /IM caffeine64.exe
@echo -----------------------------------------------------------------------------------------------------------
@echo Finalizado.
@pause
@popd
