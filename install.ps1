$ErrorActionPreference = "Stop"
  
. .\definitions.ps1

function copyRecursive($path, $dest)
{
  if (!(Test-Path -Path $dest))
  {
    New-Item $dest -itemType Directory -Force
  }
  Copy-Item -Path $path\* -Destination $dest -Recurse -Force
}

function copyHeaders($dir, $dest)
{
  if (!(Test-Path -Path $dest))
  {
    New-Item $dest -itemType Directory -Force
  }
  Copy-Item -Path $dir\*.h -Destination $dest -Force
}

function copyLib($dir, $dest)
{
  if (!(Test-Path -Path $dest))
  {
    New-Item $dest -itemType Directory -Force
  }
  Copy-Item -Path $dir\*.lib -Destination $dest -Force
}

function copyDll($dir, $dest)
{
  if (!(Test-Path -Path $dest))
  {
    New-Item $dest -itemType Directory -Force
  }
  Copy-Item -Path $dir\*.dll -Destination $dest -Force
  Copy-Item -Path $dir\LICENSE.* -Destination $dest -Force
}

# install
## sdl2
copyRecursive $sdl2\include include\SDL2

copyLib $sdl2\VisualC\SDL\Win32\Debug lib\Win32\Debug
copyLib $sdl2\VisualC\SDL\Win32\Release lib\Win32\Release
copyLib $sdl2\VisualC\SDL\x64\Debug lib\x64\Debug
copyLib $sdl2\VisualC\SDL\x64\Release lib\x64\Release
copyLib $sdl2\VisualC\SDLmain\Win32\Debug lib\Win32\Debug
copyLib $sdl2\VisualC\SDLmain\Win32\Release lib\Win32\Release
copyLib $sdl2\VisualC\SDLmain\x64\Debug lib\x64\Debug
copyLib $sdl2\VisualC\SDLmain\x64\Release lib\x64\Release

copyDll $sdl2\VisualC\SDL\Win32\Debug bin\Win32\Debug
copyDll $sdl2\VisualC\SDL\Win32\Release bin\Win32\Release
copyDll $sdl2\VisualC\SDL\x64\Debug bin\x64\Debug
copyDll $sdl2\VisualC\SDL\x64\Release bin\x64\Release
copyDll $sdl2\VisualC\SDLmain\Win32\Debug bin\Win32\Debug
copyDll $sdl2\VisualC\SDLmain\Win32\Release bin\Win32\Release
copyDll $sdl2\VisualC\SDLmain\x64\Debug bin\x64\Debug
copyDll $sdl2\VisualC\SDLmain\x64\Release bin\x64\Release

## sdl2image
copyHeaders $sdl2image include\SDL2

copyLib $sdl2image\VisualC\Win32\Debug lib\Win32\Debug
copyLib $sdl2image\VisualC\Win32\Release lib\Win32\Release
copyLib $sdl2image\VisualC\x64\Debug lib\x64\Debug
copyLib $sdl2image\VisualC\x64\Release lib\x64\Release
copyLib $sdl2image\VisualC\external\lib\x86 lib\Win32\Debug
copyLib $sdl2image\VisualC\external\lib\x86 lib\Win32\Release
copyLib $sdl2image\VisualC\external\lib\x64 lib\x64\Debug
copyLib $sdl2image\VisualC\external\lib\x64 lib\x64\Release

copyDll $sdl2image\VisualC\Win32\Debug bin\Win32\Debug
copyDll $sdl2image\VisualC\Win32\Release bin\Win32\Release
copyDll $sdl2image\VisualC\x64\Debug bin\x64\Debug
copyDll $sdl2image\VisualC\x64\Release bin\x64\Release
copyDll $sdl2image\VisualC\external\lib\x86 bin\Win32\Debug
copyDll $sdl2image\VisualC\external\lib\x86 bin\Win32\Release
copyDll $sdl2image\VisualC\external\lib\x64 bin\x64\Debug
copyDll $sdl2image\VisualC\external\lib\x64 bin\x64\Release

## sdl2ttf
copyHeaders $sdl2ttf include\SDL2

copyLib $sdl2ttf\VisualC\Win32\Debug lib\Win32\Debug
copyLib $sdl2ttf\VisualC\Win32\Release lib\Win32\Release
copyLib $sdl2ttf\VisualC\x64\Debug lib\x64\Debug
copyLib $sdl2ttf\VisualC\x64\Release lib\x64\Release
copyLib $sdl2ttf\VisualC\external\lib\x86 lib\Win32\Debug
copyLib $sdl2ttf\VisualC\external\lib\x86 lib\Win32\Release
copyLib $sdl2ttf\VisualC\external\lib\x64 lib\x64\Debug
copyLib $sdl2ttf\VisualC\external\lib\x64 lib\x64\Release

copyDll $sdl2ttf\VisualC\Win32\Debug bin\Win32\Debug
copyDll $sdl2ttf\VisualC\Win32\Release bin\Win32\Release
copyDll $sdl2ttf\VisualC\x64\Debug bin\x64\Debug
copyDll $sdl2ttf\VisualC\x64\Release bin\x64\Release
copyDll $sdl2ttf\VisualC\external\lib\x86 bin\Win32\Debug
copyDll $sdl2ttf\VisualC\external\lib\x86 bin\Win32\Release
copyDll $sdl2ttf\VisualC\external\lib\x64 bin\x64\Debug
copyDll $sdl2ttf\VisualC\external\lib\x64 bin\x64\Release
