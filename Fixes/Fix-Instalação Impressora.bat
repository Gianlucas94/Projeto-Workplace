@>nul chcp 65001
@pushd "%~dp0"
@set PATH=%PATH%;"%~dp0lib"
@title Projeto WorkPlace - Fix Instalação Impressora
@chgcolor 02
@echo ------------------------------------------------------------------------------
@echo  Projeto WorkPlace - Fix Instalação Impressora
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
@echo ## ATENCÃO - EXECUTAR APÓS A INSTALAÇÃO DA IMAGEM COM LOGIN ADMIN ##
@echo.

@net session >nul 2>&1
@if %errorLevel% == 0 (
    @chgcolor 27
    @echo Permissões administrativa confirmada.
    @echo.
    goto inicio
) else (
        @chgcolor 46
        @echo SEM PERMISSÃO! ABRA NOVAMENTE COMO ADMINISTRADOR.
        echo.
        @chgcolor 07
        @timeout 3 /nobreak
        
        @echo.
        goto eof
)
:inicio
@chgcolor 07
@echo Fix para instalação de impressoras.
@echo.
@reg import %~dp0\regs\Printer_Install.reg
@echo.
@chgcolor 02
@echo Pronto, agora pode efetuar a instalação da impressora.
@echo.
@chgcolor 07
@start explorer \\brariops1
@pause