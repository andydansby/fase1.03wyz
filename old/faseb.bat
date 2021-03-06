@echo off
SETLOCAL
if not exist zxb\zxb.exe (
  echo.
  echo Error: You need ZX Basic installed into the zxb folder.
  exit /b 1
)
if "%1"=="gfx" (
  lib\bin\Png2Rcs gfx\loading.png build\loading.rcs
  lib\bin\zx7b build\loading.rcs build\loading.rcs.zx7b
rem  lib\bin\GenTmx 3 3 10 10 gfx\map.tmx
  lib\bin\TmxCompress gfx\map.tmx build\map_compressed.bin > build\defmap.asm
  lib\bin\step1
  goto cont
)
if "%1"=="config" (
:cont
  lib\bin\sjasmplus asm\engine0.asm > nul
  lib\bin\sjasmplus asm\engine1.asm > nul
  lib\bin\sjasmplus asm\engine2.asm > nul
  lib\bin\step2
  lib\bin\zx7b build\block.bin build\block.zx7b
)
echo.
zxb\zxb main.bas -o build\main.bin
echo File main.bin compiled from main.bas
lib\bin\zx7b build\main.bin build\main.zx7b
echo.
copy /b build\map_compressed.bin+build\main.zx7b+build\block.zx7b build\engine.zx7b > nul
echo File engine.zx7b joined from map_compressed.bin, main.zx7b and block.zx7b
echo.
copy build\defload.asm build\ndefload.asm > nul
for /f %%i in ("build\engine.zx7b") do echo         DEFINE  engicm  %%~zi >> build\ndefload.asm
for /f %%i in ("build\main.zx7b")   do echo         DEFINE  maincm  %%~zi >> build\ndefload.asm
for /f %%i in ("build\main.bin")    do echo         DEFINE  mainrw  %%~zi >> build\ndefload.asm
lib\bin\sjasmplus asm\loader.asm
if exist build\player.bin.zx7b (
  lib\bin\gentape game.tzx                    ^
            basic 'game' 0  build\loader.bin  ^
             data           build\engine.zx7b ^
           stop48                             ^
             data           build\player.bin.zx7b
) else (
  lib\bin\gentape game.tzx                    ^
            basic 'game' 0  build\loader.bin  ^
             data           build\engine.zx7b
)
ENDLOCAL