@echo off
set "sourceDirectory=C:\Users\cscpv\Downloads"

if not exist "%sourceDirectory%\Pdf Documents" (
	mkdir "%sourceDirectory%\Pdf Documents"
)

if not exist "%sourceDirectory%\Office Documents" (
	mkdir "%sourceDirectory%\Office Documents"
)

if not exist "%sourceDirectory%\Compressed" (
	mkdir "%sourceDirectory%\Compressed"
)

if not exist "%sourceDirectory%\Applications" (
	mkdir "%sourceDirectory%\Applications"
)

if not exist "%sourceDirectory%\Images\WhatsApp Images" (
	mkdir "%sourceDirectory%\Images\WhatsApp Images"
)

if not exist "%sourceDirectory%\Images" (
	mkdir "%sourceDirectory%\Images"
)


for %%A in ("%sourceDirectory%\*.pdf") do (
    move "%%A" "%sourceDirectory%\Pdf Documents"
)

for %%B in ("%sourceDirectory%\*.xlsx" "%sourceDirectory%\*.xlx" "%sourceDirectory%\*.doc" "%sourceDirectory%\*.docx" "%sourceDirectory%\*.csv") do (
    move "%%B" "%sourceDirectory%\Office Documents"
)

for %%C in ("%sourceDirectory%\*.zip" "%sourceDirectory%\*.rar" "%sourceDirectory%\*.7z") do (
    move "%%C" "%sourceDirectory%\Compressed"
)

for %%D in ("%sourceDirectory%\*.exe" "%sourceDirectory%\*.msi") do (
    move "%%D" "%sourceDirectory%\Applications"
)

for %%E in ("%sourceDirectory%\WhatsApp*.jpeg" "%sourceDirectory%\WhatsApp*.jpg" "%sourceDirectory%\WhatsApp*.png") do (
    move "%%E" "%sourceDirectory%\Images\WhatsApp Images"
)

for %%E in ("%sourceDirectory%\*.jpeg" "%sourceDirectory%\*.jpg" "%sourceDirectory%\*.png") do (
    move "%%E" "%sourceDirectory%\Images"
)

echo All files moved successfully.
