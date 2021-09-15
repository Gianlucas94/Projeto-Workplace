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
@echo ## ATENÇÃO - EXECUTAR COM O USUÁRIO LOGADO ##

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
        @goto nome
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
:nome
    @set /p nome= Nome do Usuario: 
    @echo.
        @if exist %letra%:\backup\%nome% (
            goto chave
        ) else (
            @chgcolor 46
            @echo Não há esse nome no backup! verifique o nome abaixo e tente novamente:
            @chgcolor 06
            @echo.
            @for /F "usebackq" %%i IN (`dir %letra%:\backup\ /b ^| sort`) DO @echo %%i
            @echo.
            @chgcolor 07
            @pause
            goto nome
        )
:chave
    @set /p user= Chave Linde: 
    @echo.
        @if exist c:\users\%user% (
            goto restore
        ) else (
            @chgcolor 46
            @echo Perfil do usuário não encontrado! Verifique os perfis que estão na máquina abaixo e tente novamente:
            @chgcolor 06
            @echo.
            @for /F "usebackq" %%i IN (`dir c:\users\ /b ^| sort`) DO @echo %%i
            @echo.
            @chgcolor 07
            @pause
            goto chave
            ) 
)
  

:restore
:: Iniciando Caffeine para previnir que o Windows hiberne.
@start c:\temp\caffeine64.exe -noicon

:: Retornando arquivos do usuário.
@chgcolor 02
@echo ------------------------------------------------------------------------------
@echo     Backup - Retornando arquivos
@echo ------------------------------------------------------------------------------
@chgcolor 07
@robocopy "%letra%:\backup\%nome%\user files" "C:\users\%user%" /r:1 /w:1 /e /eta
@ren c:\notes notesold
@robocopy "%letra%:\backup\%nome%\c_raiz" C:\ /r:1 /w:1 /e /eta

:: Retornando Favoritos
@echo Restaurando favoritos do Chrome.
@start Chrome
@taskkill /f /im chrome.exe
@xcopy  %letra%:\backup\%nome%\Favoritos\Chrome\bookmarks "C:\users\%user%\AppData\Local\Google\Chrome\User Data\Default\" /e

@echo Restaurando favoritos do Edge.
@start msedge
@taskkill /f /im msedge.exe
@xcopy  %letra%:\backup\%nome%\Favoritos\Edge\bookmarks "C:\Users\%user%\AppData\Local\Microsoft\Edge\User Data\Default\" /e

:: Importando registros.
@chgcolor 02
@echo ------------------------------------------------------------------------------
@echo  Impressoras e mapeamentos - Importando chaves do registro
@echo ------------------------------------------------------------------------------
@chgcolor 07
@ %letra%:
@cd %letra%:\backup\%nome%\registro
@reg import mapeamento.reg
@reg import impressoras.reg
@cd \

:: Alterando Página Inicial do Internet Explorer
@echo Alterando Página inicial do internet Explorer.
@echo y|REG ADD "HKCU\Software\Microsoft\Internet Explorer\Main" /V "Start Page" /D "portalwm.sa.praxair.com" /F

@echo Fixando ícones na barra de tarefa.
c:\temp\syspin.exe "%programfiles%\internet explorer\iexplore.exe" 5386
c:\temp\syspin.exe "C:\Program files (x86)\Microsoft Office\root\Office16\OUTLOOK.exe" 5386

:: Finalizando o Caffeine64
@taskkill /f /IM caffeine64.exe
@echo -----------------------------------------------------------------------------------------------------------
@echo Finalizado
@pause
@popd   