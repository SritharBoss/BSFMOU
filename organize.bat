@echo off
set "sourceDirectory=D:\Downloads"

for %%A in ("%sourceDirectory%\*.pdf") do (
    move "%%A" "D:\Downloads\Pdf Documents"
)

for %%B in ("%sourceDirectory%\*.xlsx" "%sourceDirectory%\*.xlx" "%sourceDirectory%\*.doc" "%sourceDirectory%\*.docx") do (
    move "%%B" "D:\Downloads\Office Documents"
)

for %%C in ("%sourceDirectory%\*.zip" "%sourceDirectory%\*.rar" "%sourceDirectory%\*.7z") do (
    move "%%C" "D:\Downloads\Compressed"
)

for %%D in ("%sourceDirectory%\*.exe" "%sourceDirectory%\*.msi") do (
    move "%%D" "D:\Downloads\Applications"
)

for %%E in ("%sourceDirectory%\WhatsApp*.jpeg" "%sourceDirectory%\WhatsApp*.jpg" "%sourceDirectory%\WhatsApp*.png") do (
    move "%%E" "D:\Downloads\Images\WhatsApp Images"
)

for %%E in ("%sourceDirectory%\*.jpeg" "%sourceDirectory%\*.jpg" "%sourceDirectory%\*.png") do (
    move "%%E" "D:\Downloads\Images"
)

echo All files moved successfully.