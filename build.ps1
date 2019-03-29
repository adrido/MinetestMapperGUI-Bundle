# get usage information by using 'get-help .\build.ps1'

<#
.SYNOPSIS
Automatically build MinetestmapperGui

.DESCRIPTION
Automatically installs the reqired dependencies from vcpkg, 
executes cmake and generates a zip archive

.EXAMPLE
PS> .\build.ps1 -vcpkg_root D:\vcpkg\ -triplet x64-windows
#>
param (
    ## Specifies the path to the vcpkg.exe. e.g D:\vcpkg
    [Parameter(Mandatory = $true)]
    [string]$vcpkg_root = "D:\vcpkg",

    ## Specifies the target triplet eg. x64-windows or x68-windows-static.
    [Parameter(Mandatory = $true)] 
    [string]$triplet = "x64-windows",

    ## Specify the Visual studio version (15 = VS 2017)
    [int32]$vs_version = 15,

    ## Specify the qt version to use
    $qt_version = "5.12.1",

    ## Build a installer instead of a portable version
    [switch]$installer
)

$aTriplet = $triplet.Split('-')
$arch = $aTriplet[0]
$os = $aTriplet[1]
$linkage = $aTriplet[2]

$generator = ""
if ($vs_version -lt 14) {
    throw "Visual Studio versions older then 2015 are not supported!"
}
elseif ($vs_version -eq 14) {
    $generator = "Visual Studio 14 2015"
    $qt_dir = "C:\Qt\$qt_version\msvc2015"
}
elseif ($vs_version -eq 15) {
    $generator = "Visual Studio 15 2017"
    $qt_dir = "C:\Qt\$qt_version\msvc2017"
}
elseif ($vs_version -eq 16) {
    $generator = "Visual Studio 16 2019"
    $qt_dir = "C:\Qt\$qt_version\msvc2019"
    Write-Warning "$generator is currently not tested and may work or not"
}

$cmake_generator = $generator
if ($arch -eq "x64") {
    $cmake_generator = "$generator Win64"
    $qt_dir += "_64"
}

$build_dir = ".\build\$triplet"

if ($linkage -eq "static") {
    Write-Output "Building $arch-$os-static"
}
else {
    Write-Output "Building $arch-$os-dynamic"
}

Write-Output "Qt Dir:    $qt_dir"
Write-Output "Build Dir: $build_dir"
Write-Output "Triplet:   $triplet"
Write-Output "Generator: $cmake_generator"
Write-Output "vcpkg:     $vcpkg_root"

try { 
    & "$vcpkg_root\vcpkg" install zlib sqlite3 libgd[core,png] --triplet "$triplet"
    if ($LASTEXITCODE -ne 0) {throw "Error while installing dependencies"}

    if (!(test-path $build_dir)) {
        New-Item -ItemType Directory -Force -Path $build_dir
    }

    Push-Location $build_dir
    if (Test-Path "CMakeCache.txt") {
        Remove-Item "CMakeCache.txt" # Perform a clean build
    }
    if($installer) {
        $portable = "OFF"
    }
    else {
        $portable = "ON"
    }

    cmake `
        -DBUILD_PORTABLE="$portable" `
        ../.. -G"$cmake_generator" `
        -DVCPKG_TARGET_TRIPLET="$triplet" `
        -DVCPKG_APPLOCAL_DEPS=ON `
        -DCMAKE_TOOLCHAIN_FILE="$vcpkg_root/scripts/buildsystems/vcpkg.cmake" `
        -DCMAKE_BUILD_TYPE=Release `
        -DCMAKE_PREFIX_PATH="$qt_dir\lib\cmake"
    if ($LASTEXITCODE -ne 0) {throw "Error while configuring"}

    cmake --build . --config Release
    if ($LASTEXITCODE -ne 0) {throw "Error while building"}

    if($installer){
        cpack -G "WIX"
        if ($LASTEXITCODE -ne 0) {throw "Error while packing Installer"}
    }
    else {
        cpack -G "ZIP"
        if ($LASTEXITCODE -ne 0) {throw "Error while packing"}
    }
}
catch { 
    Write-Error $_.Exception.Message 
    exit 1
}
Finally {
    Pop-Location
}


