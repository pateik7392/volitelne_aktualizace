@echo off

echo volitelna aktualizace pro verzi 2.0.0

echo prosim pokud najdete neaky bug prosim nahlaste na muj discord: pateik7392#7757

call chatbot_settings.txt

REM Pouziti nastavení v chatbotu
echo Barva pozadi: %background_color%
echo Barva textu: %text_color%
echo Velikost pisma: %font_size%

timeout /t 5 > nul

if not exist chatbot_data.txt (
    type nul > chatbot_data.txt
)

setlocal EnableDelayedExpansion

@echo off

if not exist chatbot_user_data.txt (
  set /p name=Zadejte sve jmeno:
  echo Jmeno:%name% > chatbot_user_data.txt
) else (
  for /f "tokens=2 delims=:" %%a in ('findstr /c:"Jmeno:" chatbot_user_data.txt') do set "name=%%a"
)


set "user_data=Jmeno:%name%"

echo !user_data! >> chatbot_user_data.txt
echo data byla ulozena do souboru

:menu
echo %name% Vyberte mod:
echo 1. Zapis
echo 2. Zobraz
echo 3. Otazky
echo 4. Verze a novinky
echo 5. nastaveni
echo 6. statistika
echo 7. volitelne aktualizace (beta)
set /p choice=Volba:
if "%choice%"=="1" goto zapis
if "%choice%"=="2" goto zobraz
if "%choice%"=="3" goto otazky
if "%choice%"=="4" goto verzeanovinky
if "%choice%"=="5" goto nastaveni
if "%choice%"=="6" goto statistika
if "%choice%"=="7" goto volitelneaktualizace
echo Nespravna volba. Zvolte 1, 2, 3, 4, 5, 6 nebo 7.
timeout /t 2 >nul
goto menu

:zapis
set /p query=Zadejte otazku:
set /p data=Vase data:
echo !query!:>>chatbot_data.txt
echo !data!>>chatbot_data.txt
echo Data zapsana do souboru.
timeout /t 2 >nul
goto zapis

:zobraz
set /p query=Zadejte otazku:
set found=0
for /f "tokens=*" %%a in (chatbot_data.txt) do (
    if /i "%%a"=="%query%:" (
        set found=1
    ) else if !found!==1 (
        set found=0
        set answer=%%a
        echo Odpoved: !answer!
        timeout /t 5 >nul
        goto :zobraz
    )
)
if !found!==0 (
    echo Bohuzel nebyla nalezena zadna odpoved na otazku: %query%
    timeout /t 2 >nul
)
goto zobraz

:otazky
echo Zadane otazky:
echo.
for /f "delims=:" %%a in ('type chatbot_data.txt ^| findstr /c:"?"') do (
  echo %%a
)
timeout /t 5 >nul
goto menu

:verzeanovinky
echo volitelna aktualizace nemá updaty

echo stisknete jakoukoliv klavesu pro pokracovani
timeout /t 99999 >nul
goto menu

:nastaveni
cls
echo ===================================================
echo Nastaveni vzhledu
echo ===================================================
echo.
echo Vyberte barvu pozadi:
echo [1] Bila
echo [2] Cerna
echo [3] Modra
echo [4] Zelena
echo [5] Zluta
echo [6] Cervena
echo [7] Fialova
echo.
set /p color_choice="Vase volba: "
if "%color_choice%"=="1" set "background_color=0F"
if "%color_choice%"=="2" set "background_color=0B"
if "%color_choice%"=="3" set "background_color=01"
if "%color_choice%"=="4" set "background_color=02"
if "%color_choice%"=="5" set "background_color=06"
if "%color_choice%"=="6" set "background_color=0C"
if "%color_choice%"=="7" set "background_color=05"

echo.
echo Vyberte barvu textu:
echo [1] Cerna
echo [2] Bila
echo [3] Modra
echo [4] Zelena
echo [5] Zluta
echo [6] Cervena
echo [7] Fialova
echo.
set /p text_choice="Vase volba: "
if "%text_choice%"=="1" set "text_color=0F"
if "%text_choice%"=="2" set "text_color=0B"
if "%text_choice%"=="3" set "text_color=01"
if "%text_choice%"=="4" set "text_color=02"
if "%text_choice%"=="5" set "text_color=06"
if "%text_choice%"=="6" set "text_color=0C"
if "%text_choice%"=="7" set "text_color=05"

echo.
echo Vyberte velikost pisma:
echo [1] Male
echo [2] Stredni
echo [3] Velke
echo.
set /p font_choice="Vase volba: "
if "%font_choice%"=="1" set "font_size=10"
if "%font_choice%"=="2" set "font_size=14"
if "%font_choice%"=="3" set "font_size=18"

echo.
set /p save_choice="Chcete ulozit nastaveni? [y/n]: "
if /i "%save_choice%"=="y" (
echo set "background_color=%background_color%">chatbot_settings.txt
echo set "text_color=%text_color%">>chatbot_settings.txt
echo set "font_size=%font_size%">>chatbot_settings.txt
echo echo Nastaveni vzhledu bylo ulozeno.>>chatbot_settings.txt
)

if defined background_color color %background_color%
if defined text_color color %text_color%
timeout /t 2 > nul
goto menu

:statistika
echo nastaveni funguje (bugs 1)
echo nastaveni jmena (bugs 1)
echo jinak vse funguje

:volitelneaktualizace
echo dostupne volitelne aktualizace (0)
echo ???
echo odkaz

:end
pause>nul
