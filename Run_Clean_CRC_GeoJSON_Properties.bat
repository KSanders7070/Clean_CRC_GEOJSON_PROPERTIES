@echo off

cls

setlocal

ECHO.
ECHO.
ECHO This batch script will launch folder browsers prompting you to
ECHO select a source directory and an output directory.
ECHO.
ECHO Then this script will launch the Clean_CRC_GeoJSON_Properties
ECHO Python script and process all .geojson files within the selected
ECHO source directory and output the cleaned files to your selected
ECHO output directory.
ECHO.
ECHO The python script will generally:
ECHO     Remove all overwriting properties objects in each feature of a
ECHO     geojson constructed for CRC that is not an isDefault feature.
ECHO     The isDefaults will be placed at the beginning of the feature collection.
ECHO.
ECHO     RULES:  
ECHO         * In a isDefault feature, the properties will remain as they are.  
ECHO         * In a feature that is a "Type:Point" but has a TEXT property, the
ECHO           TEXT properties object will remain but all other objects will be
ECHO           removed from the properties.  
ECHO         * In all other features properties objects will be removed.
ECHO.
ECHO Press any key to begin...
pause>nul

:: Get the source directory

cls

echo Select the source directory containing the .geojson files:
set "sourceDir="
for /f "usebackq tokens=*" %%i in (`powershell "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.FolderBrowserDialog; [void]$f.ShowDialog(); $f.SelectedPath"`) do set "sourceDir=%%i"
if "%sourceDir%"=="" (
    echo No source directory selected. Exiting.
    exit /b 1
)

:: Get the output directory

cls

echo Select the output directory for the cleaned .geojson files:
set "outputDir="
for /f "usebackq tokens=*" %%i in (`powershell "Add-Type -AssemblyName System.Windows.Forms; $f = New-Object System.Windows.Forms.FolderBrowserDialog; [void]$f.ShowDialog(); $f.SelectedPath"`) do set "outputDir=%%i"
if "%outputDir%"=="" (
    echo No output directory selected. Exiting.
    exit /b 1
)

:: Process each .geojson file in the source directory
for %%f in ("%sourceDir%\*.geojson") do (
    echo Processing "%%f"
    python Clean_CRC_GeoJSON_Properties.py "%%f" "%outputDir%\%%~nf_CleanProperties.geojson" --pretty
)

echo All files processed. Press any key to exit...
pause>nul
exit /b 1
