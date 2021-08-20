@pushd "%~dp0"
@title Projeto WorkPlace - Parte 2 v1.6
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 2 v1.6
@echo ------------------------------------------------------------------------------
@echo .########.####.##.....##.####.########
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##...##...##...##.....##...
@echo ....##.....##....##.##....##.....##...
@echo ....##....####....###....####....##...
@color b
@echo. v1.5
@echo ## ATENCAO - EXECUTAR APOS A INSTALACAO DA IMAGEM COM LOGIN ADMIN ##
@cd \

@set /p letra= Letra do HD Externo:
@echo.

:: Dando permissão para escrita no C:\
icacls "C:" /grant Everyone:M

:: Altera TimeZone
@echo Alterando Timezone...
@tzutil /s "E. South America Standard Time"
@echo.
@echo.

:: Instalando e restaurando programas.
@echo  ---Instalando softwares--
@robocopy %letra%:\Programas_Linde\ c:\Temp /r:1 /w:1 /e
@echo.

@echo Instalando Chrome:
@start /w c:\Temp\ChromeSetup.exe
@taskkill /IM /f chrome.exe
@echo.

@echo Instalando Driver MaxxAudio:
@start /w c:\Temp\MaxxAudio.exe /s
@echo.

@echo Instalando notes
@start /w c:\Temp\Notes8.5.3\setuplocal.bat
@echo.
@echo ---------------------------


@echo Finalizado.
@pause
@popd
