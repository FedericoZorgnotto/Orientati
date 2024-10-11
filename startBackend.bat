@echo off

REM aggiorno la repository 
echo Aggiornamento della repository in corso...
git pull
git submodule update --init --recursive

REM Controllo se esiste il container Docker Vallauri_Orientamento_backend
echo Rimozione del container Docker Vallauri_Orientamento_backend in corso...

FOR /F "tokens=*" %%i IN ('docker ps -a --filter "name=Vallauri_Orientamento_backend" --format "{{.Names}}"') DO (
    IF "%%i"=="Vallauri_Orientamento_backend" (
        docker stop Vallauri_Orientamento_backend >nul 2>&1
        docker rm Vallauri_Orientamento_backend >nul 2>&1
    )
)

REM compilo la nuova immagine Docker Vallauri_Orientamento_backend
echo Compilazione dell\'immagine Docker Vallauri_Orientamento_backend in corso...
docker build -t vallauri_orientamento_backend ./backend/

REM avvio il container Docker Vallauri_Orientamento_backend
echo Avvio del container Docker Vallauri_Orientamento_backend in corso...
docker run -d -p 8000:8000 --name Vallauri_Orientamento_backend vallauri_orientamento_backend

echo Il container docker Vallauri_Orientamento_backend  e' stato avviato correttamente, è accessibile all'indirizzo http://127.0.0.1:8000/.