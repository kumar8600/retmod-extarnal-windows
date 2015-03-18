. .\definitions.ps1

$sdl2url = "https://www.libsdl.org/release/$sdl2.zip"
$sdl2imageurl = "http://www.libsdl.org/projects/SDL_image/release/$sdl2image.zip"
$sdl2ttfurl = "http://www.libsdl.org/projects/SDL_ttf/release/$sdl2ttf.zip"

function download($url, $dest)
{
  echo "Downloading $url"
  Invoke-WebRequest $url -OutFile $dest
  echo "Done."
}

function unzip($filename)
{
  echo "Unzipping $filename"
  $shell_app=new-object -com shell.application
  $zip_file = $shell_app.namespace((Get-Location).Path + "\$filename")
  $destination = $shell_app.namespace((Get-Location).Path)
  $destination.Copyhere($zip_file.items(), 0x10)
  echo "Done."
}

download $sdl2url .\$sdl2.zip
download $sdl2imageurl .\$sdl2image.zip
download $sdl2ttfurl .\$sdl2ttf.zip

unzip "$sdl2.zip"
unzip "$sdl2image.zip"
unzip "$sdl2ttf.zip"
