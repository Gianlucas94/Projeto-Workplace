@pushd "%~dp0"
@title Projeto WorkPlace - Parte 2 v1.3
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Parte 2 v1.3
@echo ------------------------------------------------------------------------------
@echo .########.####.##.....##.####.########
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##..##.....##..##.....##...
@echo ....##.....##...##...##...##.....##...
@echo ....##.....##....##.##....##.....##...
@echo ....##....####....###....####....##...
@color b
@echo. v1.1
@echo ## ATENCAO - EXECUTAR APOS A INSTALACAO DA IMAGEM COM LOGIN ADMIN ##
@cd \

:: Dando permissão para escrita no C:\
icacls "C:" /grant Everyone:M

:: Altera TimeZone
@echo Alterando Timezone...
@tzutil /s "E. South America Standard Time"
@echo.
@echo.

:: Instalando e restaurando programas.
@echo  ---Instalando softwares--
@robocopy D:\Programas_Linde\ c:\Temp /r:1 /w:1 /e
@echo.

@echo Instalando Edge:
@start /w c:\Temp\Edge\MicrosoftEdgeEnterpriseX64.msi
@echo.

@echo Instalando Chrome:
@start /w c:\Temp\ChromeSetup.exe
@taskkill /IM chrome.exe
@echo.

@echo Instalando notes
@start /w c:\Temp\Notes8.5.3\setuplocal.bat
@echo.
@echo ---------------------------


@echo Finalizado.
@pause
@popd
