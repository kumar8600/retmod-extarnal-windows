$ErrorActionPreference = "Stop"

. .\definitions.ps1

function exitOnError()
{
  if ($LastExitCode -ne 0)
  {
    exit $LastExitCode
  }
}

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
  Copy-Item -Path $dir\*.dll -Destination $dest -Force
  Copy-Item -Path $dir\LICENSE.* -Destination $dest -Force
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

devenv $sdl2\VisualC\SDL_VS2013.sln /upgrade
msbuild $sdl2\VisualC\SDL_VS2013.sln --% /t:SDL2;SDL2main /p:Configuration=Debug /p:Platform=Win32
exitOnError
msbuild $sdl2\VisualC\SDL_VS2013.sln --% /t:SDL2;SDL2main /p:Configuration=Debug /p:Platform=x64
exitOnError
msbuild $sdl2\VisualC\SDL_VS2013.sln --% /t:SDL2;SDL2main /p:Configuration=Release /p:Platform=Win32
exitOnError
msbuild $sdl2\VisualC\SDL_VS2013.sln --% /t:SDL2;SDL2main /p:Configuration=Release /p:Platform=x64
exitOnError

copyRecursive $sdl2 SDL # for sdl2image and sdl2ttf

devenv $sdl2image\VisualC\SDL_image_VS2012.sln /upgrade
msbuild $sdl2image\VisualC\SDL_image_VS2012.sln --% /p:AdditionalIncludePaths=$sdl2includeabs /p:Configuration=Debug /p:Platform=Win32
exitOnError
msbuild $sdl2image\VisualC\SDL_image_VS2012.sln --% /p:Configuration=Debug /p:Platform=x64
exitOnError
msbuild $sdl2image\VisualC\SDL_image_VS2012.sln --% /p:Configuration=Release /p:Platform=Win32
exitOnError
msbuild $sdl2image\VisualC\SDL_image_VS2012.sln --% /p:Configuration=Release /p:Platform=x64
exitOnError

devenv $sdl2ttf\VisualC\SDL_ttf_VS2012.sln /upgrade
devenv $sdl2ttf\VisualC\SDL_ttf_VS2010.sln /upgrade # SDL's bug? This is required
msbuild $sdl2ttf\VisualC\SDL_ttf_VS2012.sln --% /p:Configuration=Debug /p:Platform=Win32
exitOnError
msbuild $sdl2ttf\VisualC\SDL_ttf_VS2012.sln --% /p:Configuration=Debug /p:Platform=x64
exitOnError
msbuild $sdl2ttf\VisualC\SDL_ttf_VS2012.sln --% /p:Configuration=Release /p:Platform=Win32
exitOnError
msbuild $sdl2ttf\VisualC\SDL_ttf_VS2012.sln --% /p:Configuration=Release /p:Platform=x64
exitOnError

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
