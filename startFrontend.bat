@echo off

REM aggiorno la repository 
echo Aggiornamento della repository in corso...
git pull
git submodule update --init --recursive --remote

REM Controllo se esiste il container Docker Vallauri_Orientamento_Frontend
echo Rimozione del container Docker Vallauri_Orientamento_Frontend in corso...

FOR /F "tokens=*" %%i IN ('docker ps -a --filter "name=Vallauri_Orientamento_Frontend" --format "{{.Names}}"') DO (
    IF "%%i"=="Vallauri_Orientamento_Frontend" (
        docker stop Vallauri_Orientamento_Frontend >nul 2>&1
        docker rm Vallauri_Orientamento_Frontend >nul 2>&1
    )
)

REM compilo la nuova immagine Docker Vallauri_Orientamento_Frontend
echo Compilazione dell\'immagine Docker Vallauri_Orientamento_Frontend in corso...
docker build -t vallauri_orientamento_frontend ./frontend/

REM avvio il container Docker Vallauri_Orientamento_Frontend
echo Avvio del container Docker Vallauri_Orientamento_Frontend in corso...
docker run -d -p 80:80 --name Vallauri_Orientamento_Frontend vallauri_orientamento_frontend

echo Il container docker Vallauri_Orientamento_Frontend  e' stato avviato correttamente, e' accessibile all'indirizzo http://127.0.0.1:80/.