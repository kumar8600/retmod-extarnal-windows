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
