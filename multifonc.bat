@echo off
chcp 65001 >nul
color B
rem Mini Launcher avec ASCII art

:home
cls
color B

:: Header ASCII art
echo  ██████╗    ██████╗	 ███    ██╗   █████╗    ██████╗ ███████╗  ██████╗  ██╗   ██╗
echo ██╔════╝   ██╔═══██╗     ████   ██║  ██╔══██╗  ╚═██╔══╝ ╚═══██╔╝  ██╔═██║  ╚██╗ ██╔╝
echo ██║        ██║   ██║     ██ ██  ██║  ██   ██╗    ██║       ██╔╝   ██║ ██║   ╚████╔╝
echo ██║ ████╗  ╚██████╔╝	 ██  ██ ██║  ███████║    ██║      ██╔╝    ██║ ██║    ╚██╔╝
echo ██║   ██║   ╚═══██║	 ██   ████║  ██╔══██║    ██║     ██╔╝     ██╚═██║   ██╔██╗
echo ╚██████╔╝  ██████╔╝	 ██    ███║  ██║  ██║    ██║    ███████║  ██████║  ██╔╝ ██╗
echo  ╚═════╝   ╚═════╝	 ╚═╝    ╚═╝  ╚═╝  ╚═╝  ╚════╝   ╚══════╝  ╚═════╝  ╚═╝  ╚═╝
pause

echo 1 = site  	3 = antivirus
echo.
echo 5 = where (fichier)
echo.
echo 2 = oo    	4 =ez
pause

set /p choix="Choix? : "
if "%choix%"=="1" goto 1
if "%choix%"=="2" goto 2
if "%choix%"=="3" goto 3
if "%choix%"=="4" goto 4
if "%choix%"=="5" goto 5

:1
@echo off
color B
title Mini Launcher

:home
cls
echo ============================
echo      Mini Google (CMD)
echo ============================
echo.
echo Tape :
echo  - google
echo  - youtube
echo  - roblox
echo  - discord
echo  - exit (pour quitter)
echo.
set /p cmd=Commande : 

:: Quitter
if /i "%cmd%"=="exit" exit

:: Ouvrir sites dans le navigateur par défaut
if /i "%cmd%"=="google" (
    start "" "https://www.google.com"
    goto home
)

if /i "%cmd%"=="youtube" (
    start "" "https://www.youtube.com"
    goto home
)

if /i "%cmd%"=="roblox" (
    start "" "https://www.roblox.com"
    goto home
)

if /i "%cmd%"=="discord" (
    start "" "https://discord.com/app"
    goto home
)

:: Si commande inconnue
echo.
echo Commande inconnue.
pause
goto home

:2
cls
echo Vous avez choisi 2
pause

:ask
set /p voir="Voir dessin? y/n : "
if /i "%voir%"=="y" goto art2
if /i "%voir%"=="n" goto menu
if /i "%voir%"=="rickroll-rick-roll" goto rickroll

:3
:: =========================
:: ANTIVIRUS LITE - MENU 3
:: =========================
@echo off
chcp 65001 >nul
title Antivirus Lite
color B
setlocal EnableDelayedExpansion

set "LOG=%temp%\Antivirus_Report.txt"
if exist "%LOG%" del "%LOG%"

:av_menu
cls
echo ================================
echo        ANTIVIRUS LITE
echo ================================
echo 1 - Scan fichiers suspects
echo 2 - Scan programmes au demarrage
echo 3 - Scan processus suspects
echo 4 - Voir rapport
echo 5 - Scan avance (DOSSIER)
echo 6 - Retour launcher
echo.
set /p av=Choix : 

if "%av%"=="1" goto av_scan_files
if "%av%"=="2" goto av_startup
if "%av%"=="3" goto av_process
if "%av%"=="4" goto av_report
if "%av%"=="5" goto av_scan_folder
if "%av%"=="6" exit
goto av_menu

:: =========================
:: 1) SCAN FICHIERS SUSPECTS
:: =========================
:av_scan_files
cls
echo Scan fichiers suspects...
echo ================================ >> "%LOG%"
echo SCAN FICHIERS - %date% %time% >> "%LOG%"

set "FOUND=%temp%\av_found.txt"
if exist "%FOUND%" del "%FOUND%"

for %%D in ("%AppData%" "%Temp%" "%ProgramData%") do (
    if exist "%%~D" (
        dir "%%~D\*.exe" "%%~D\*.bat" "%%~D\*.vbs" "%%~D\*.js" "%%~D\*.ps1" /s /b 2>nul >> "%FOUND%"
    )
)

if not exist "%FOUND%" (
    echo Aucun fichier suspect trouve.
    echo Aucun fichier suspect >> "%LOG%"
    pause
    goto av_menu
)

type "%FOUND%"
type "%FOUND%" >> "%LOG%"
pause
goto av_menu

:: =========================
:: 2) DEMARRAGE
:: =========================
:av_startup
cls
echo Programmes au demarrage :
echo ================================ >> "%LOG%"
echo STARTUP - %date% %time% >> "%LOG%"

powershell -NoProfile -Command ^
"Get-CimInstance Win32_StartupCommand | Select Name,Command | Format-Table -AutoSize"

powershell -NoProfile -Command ^
"Get-CimInstance Win32_StartupCommand | Select Name,Command | Out-File '%LOG%' -Append"

pause
goto av_menu

:: =========================
:: 3) PROCESSUS
:: =========================
:av_process
cls
echo Processus suspects (AppData / Temp)
echo ================================ >> "%LOG%"
echo PROCESSUS - %date% %time% >> "%LOG%"

powershell -NoProfile -Command ^
"Get-Process | Where {$_.Path -match 'AppData|Temp'} | Select Name,Path | Format-Table -AutoSize"

powershell -NoProfile -Command ^
"Get-Process | Where {$_.Path -match 'AppData|Temp'} | Select Name,Path | Out-File '%LOG%' -Append"

pause
goto av_menu

:: =========================
:: 4) RAPPORT
:: =========================
:av_report
cls
if exist "%LOG%" (
    type "%LOG%"
) else (
    echo Aucun rapport disponible.
)
pause
goto av_menu

:: =========================
:: 5) SCAN AVANCE DOSSIER
:: =========================
:av_scan_folder
cls
title Antivirus Lite - Scan Dossier
color B

echo =========================================
echo   SCAN AVANCE - DOSSIER COMPLET
echo =========================================
echo.
set /p "target=Chemin COMPLET du DOSSIER : "

if not exist "%target%" (
    echo [ERREUR] Dossier introuvable.
    pause
    goto av_menu
)

if not exist "%target%\*" (
    echo [ERREUR] Ceci n'est pas un dossier.
    pause
    goto av_menu
)

echo ================================ >> "%LOG%"
echo SCAN DOSSIER - %target% - %date% %time% >> "%LOG%"

set total=0
set danger=0

for /r "%target%" %%F in (*.bat *.cmd *.vbs *.js *.ps1 *.py *.exe *.scr) do (
    set /a total+=1
    set score=0
    set "reasons="
    set "extfile=%%~xF"

    :: EXTENSION
    set /a score+=15
    set "reasons=[EXT]"

    :: MOTS CLES
    findstr /i /m "token webhook discord grab password cookie login" "%%F" >nul && (
        set /a score+=40
        set "reasons=!reasons! [STEALER]"
    )

    findstr /i /m "powershell -enc bypass hidden invoke-webrequest" "%%F" >nul && (
        set /a score+=35
        set "reasons=!reasons! [POWERSHELL]"
    )

    findstr /i /m "schtasks reg add RunOnce startup" "%%F" >nul && (
        set /a score+=30
        set "reasons=!reasons! [PERSISTENCE]"
    )

    findstr /i /m "base64 eval atob fromcharcode xor" "%%F" >nul && (
        set /a score+=25
        set "reasons=!reasons! [OBFUSCATION]"
    )

    findstr /i /m "curl wget bitsadmin http https socket tcp" "%%F" >nul && (
        set /a score+=30
        set "reasons=!reasons! [RESEAU]"
    )

    if !score! GEQ 60 (
        set /a danger+=1
        echo [!!] !score! - %%F
        echo [!!] %%F SCORE=!score! !reasons! >> "%LOG%"
    ) else (
        echo [OK] !score! - %%F
        echo [OK] %%F SCORE=!score! >> "%LOG%"
    )
)

echo.
echo =========================================
echo FIN DU SCAN
echo Fichiers analyses : %total%
echo Fichiers suspects : %danger%
echo =========================================
echo.
pause
goto av_menu

:4
cls
echo Vous avez choisi 4
pause

:ask
set /p voir="Voir dessin? y/n : "
if /i "%voir%"=="y" goto art4
if /i "%voir%"=="n" goto menu
if /i "%voir%""=="rickroll-rick-roll" goto rickroll

:5
cls
echo === Recherche de fichier ===
echo.
echo Choisis l'extension du fichier :
echo 1. .exe
echo 2. .py
echo 3. .txt
echo 4. .png
set /p choix=Entrez le numero correspondant : 

rem Définir l'extension selon le choix
if "%choix%"=="1" set "ext=exe"
if "%choix%"=="2" set "ext=py"
if "%choix%"=="3" set "ext=txt"
if "%choix%"=="4" set "ext=png"

echo.
set /p fichier=Ecrit le nom du fichier ( *nom du fichier* ) : 

color B
echo.
echo Recherche en cours... Cela peut prendre quelques secondes.
echo.

:: Créer un fichier temporaire pour stocker les résultats
set "tmpfile=%temp%\resultats.txt"
if exist "%tmpfile%" del "%tmpfile%"

:: Boucle sur les dossiers les plus pertinents
(
    if exist "C:\Program Files" (
        dir "C:\Program Files\*%fichier%*.%ext%" /s /b 2>nul
    )
    if exist "C:\Program Files (x86)" (
        dir "C:\Program Files (x86)\*%fichier%*.%ext%" /s /b 2>nul
    )
    if exist "C:\Users" (
        dir "C:\Users\*%fichier%*.%ext%" /s /b 2>nul
    )
) > "%tmpfile%"

cls
echo === Resultats de la recherche ===
echo.

:: Vérifie si des fichiers ont été trouvés
if exist "%tmpfile%" (
    for /f "delims=" %%l in (%tmpfile%) do echo %%l
) else (
    echo Aucun fichier trouve.
)

:: Supprimer le fichier temporaire
del "%tmpfile%"

echo.
pause
goto home


:art
cls
echo.
echo                                      :**+ :::+*@@.
echo                              +: @ = =.  :#@@@@@@@@                 :     .=*@@#     -
echo                 @@@@-. :=: +@@.:% *=@@:   @@@@@@          :#=::     .:@=@@@@@@@@@@@@@@@@@@@@--.-:
echo             .#@@@@@@@@@@@@@@@@@@:# .@@   #@@    :@-     +@@:@@@+@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*
echo             #*   :%@@@@@@@@@@:   .@@#*              ..  ##@ *#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-:- %=
echo                   *@@@@@@@@@@@@%@@@@@@@            = @=+@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@+   #.
echo                   #@@@@@@@@@##@@@@@= =#              #@@@#@@@@%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
echo                  @@@@@@@@@@@#+#@@=                 :@@@-.#-*#@.  .@@.=%@@@@%@@@@@@@@@@@@@@@@@=  +
echo                 :@@@@@@@@@@@@@@:                   :@@    # - @@@@@@@ =@@@*#*@@@@@@@@@@@@@=.=-  #:
echo                  :@@@@@@@@@@@+                     @@@@@@@: :    @@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                   #@@@@@    @                     #%@@@@@@@@@@@@@@@@@:@@@@@@@@@@@@#@@@@@@@@@:
echo                     @@@     .                    @@@@@@@@@@@@@@@@-%@@@%@#   @@@@@@#=@#@@@@@==
echo                     =@@##@   =:*.                @@@@@@*@@@@@@@@@@-=@@@@.    +@@@:  %#@@#=   :
echo                         .=@.                     #@@@@@@@@#@@@@@@@@+#:        %@      *%@=
echo                            . @@@@@@               @#@@*@@@@@@@@@@@@@@@=        :-     -       =.
echo                             :@@@@@@@#=                   @@@@@@@@@@@@-               :+%  .@=
echo                            -@@@@@@@@@@@@                 @+@@@@*+@@#                   @. @@.#   # :
echo                             @@@@@@@@@@@@@@@               @@@@@*@@@                     :=.        @@@.
echo                              @@@@@@@@@@@@@                #@@@@@@%@.                             :  :
echo                               *@@@@@@@@@@%               :@@@@@@@@@ @@.                      .@@@@=:@
echo                                :@@@@@@@@@                 #@@@@@@   @:                    .#@@@@@@@@@@
echo                                :@@@@%@@                   .@@@@@-   .                     @@@@@@@@@@@@*
echo                                :@@@@@@.                    *@@@-                          @@@@#@@@@@@@
echo                                .@@@@@                                                           =@@@:    @=
echo                                 =@@                                                              =    #+
echo                                  @%
pause
goto home

:art2
cls
echo                                                 @@@@@@@@@@@@@@@@@@@
echo                                         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                                    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                             @@@@@@@@@@@@@@@@@@                       @@@@@@@@@@@@@@@@@@
echo                           @@@@@@@@@@@@@@                                   @@@@@@@@@@@@@@@
echo                        @@@@@@@@@@@@@              @@@@@@@@@@@@@@@              @@@@@@@@@@@@@
echo                       @@@@@@@@@@@          @@@@@@@@@@@@@@@@@@@@@@@@@@@@@          @@@@@@@@@@@
echo                       @@@@@@@@         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@         @@@@@@@@
echo                        @@@@@        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        @@@@@
echo                                  @@@@@@@@@@@@@@@                   @@@@@@@@@@@@@@@
echo                                @@@@@@@@@@@@@                           @@@@@@@@@@@@@
echo                               @@@@@@@@@@            @@@@@@@@@@@            @@@@@@@@@@
echo                                @@@@@@@         @@@@@@@@@@@@@@@@@@@@@         @@@@@@@
echo                                            @@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                                          @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                                         @@@@@@@@@@@             @@@@@@@@@@@
echo                                        @@@@@@@@@                   @@@@@@@@@
echo                                         @@@@@@        @@@@@@@        @@@@@@
echo                                                    @@@@@@@@@@@@@
echo                                                   @@@@@@@@@@@@@@@
echo                                                  @@@@@@@@@@@@@@@@@
echo                                                  @@@@@@@@@@@@@@@@@
echo                                                   @@@@@@@@@@@@@@@
echo                                                    @@@@@@@@@@@@@
echo                                                       @@@@@@@
pause
goto home

:art3
cls
echo.
echo                                          ...:----:...
echo                                     .:=#@@@@@@@@@@@@@@%*-..
echo                                  .:#@@@@@@@%#*****#%@@@@@@@+..
echo                               ..-@@@@@%-...... ........+@@@@@@..
echo                               :%@@@@=..   .#@@@@@@@@#=....+@@@@*.
echo                             .+@@@@=.      .*@@@%@@@@@@@@=...*@@@@:.
echo                            .#@@@%.                 .=@@@@@=. .@@@@-.
echo                           .=@@@#.                    .:%@@@*. -@@@%:.
echo                           .%@@@-                       .*@@*. .+@@@=.
echo                           :@@@#.                              .-@@@#.
echo                           -@@@#                                :%@@@.
echo                           :@@@#.                              .-@@@#.
echo                           .%@@@-.                             .+@@@=.
echo                           .+@@@#.                             -@@@%:.
echo                            .*@@@%.                          .:@@@@-.
echo                             .+@@@@=..                     ..*@@@@:.
echo                               :%@@@@-..                ...+@@@@*.
echo                               ..-@@@@@%=...         ...*@@@@@@@@#.
echo                                  .:*@@@@@@@%*++++**@@@@@@@@=:*@@@@#:.
echo                                     ..=%@@@@@@@@@@@@@@%#-.   ..*@@@@%:.
echo                                        .....:::::::....       ...+@@@@%:
echo                                                                  ..+@@@@%-.
echo                                                                    ..=@@@@%-.
echo                                                                      ..=@@@@@=.
echo                                                                         .=%@@@@=.
echo                                                                          ..-%@@@-.
echo                                                                              ....
pause
goto home

:art4
cls
echo                                             @@@@                   @%@@
echo                                       @@@@@@@@@@@@               @@@@@@@@@@%
echo                                  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                                 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%
echo                                %@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                               @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                              @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                            @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%
echo                           @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                          %@@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@@    @@@@@@@@@@@@@@@@@@%
echo                          %@@@@@@@@@@@@@@@@        %@@@@@@@@@@@%@        @@@@@@@@@@@@@@@@@
echo                          %@@@@@@@@@@@@@@@          @@@@@@@@@@@@          @@@@@@@@@@@@@@@%
echo                         %@@@@@@@@@@@@@@@@          @@@@@@@@@@@%          %@@@@@@@@@@@@@@@@
echo                         @@@@@@@@@@@@@@@@@%         @@@@@@@@@@@%         %@@@@@@@@@@@@@@@@@
echo                         @@@@@@@@@@@@@@@@@@@      %@@@@@@@@@@@@@@@      @@@@@@@@@@@@@@@@@@%
echo                         %@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%
echo                         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%
echo                         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo                         @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%
echo                           @%@@@@@@@@@@@@@%@@   @@@@%@@@@@@@@@%%%@%@@  @@@@@@@@@@@@@@@@@@
echo                              @@%@@@@@@@@@@@@@                        @%@@@@@@@@@@@%@@
echo                                   @%@@@@@@@                            @@@@@@%%@
echo                                         @@                              @@
pause
goto home

:rickroll
color B
powershell -command ^
"$p = Start-Process curl 'ASCII.live/can-you-hear-me' -NoNewWindow -PassThru; ^
Read-Host 'Appuie sur ENTREE pour arreter'; ^
$p.Kill()"
goto home
