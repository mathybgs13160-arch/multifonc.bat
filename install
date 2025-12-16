@echo off
SETLOCAL

REM Chemin où se trouve ton projet local
SET REPO_DIR=C:\Chemin\Vers\Ton\Projet

REM URL de ton dépôt GitHub
SET GIT_URL=https://github.com/Utilisateur/MonProjet.git

REM Vérifie si le dossier existe
IF NOT EXIST "%REPO_DIR%" (
    echo Clonage du dépôt...
    git clone %GIT_URL% "%REPO_DIR%"
) ELSE (
    echo Mise à jour du dépôt...
    cd "%REPO_DIR%"
    git pull origin main
)

echo Script mis à jour avec succès !
pause
ENDLOCAL
