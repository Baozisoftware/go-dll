@echo off

rd bin /s /q
mkdir bin\32
mkdir bin\64

set fn=test
set gn=test.go
set dn=test.def

set tmp=%path%
::使跨平台编译使用CGO
set CGO_ENABLED=1

::设置32位GCC
set path=%tmp%;c:\mingw\i686\bin
::设置目标平台(32位)
set GOARCH=386
::编译32位静态库
go build -buildmode=c-archive -o bin\32\%fn%.a %gn%
::生成DLL,LIB文件
gcc %dn% bin\32\%fn%.a -shared -lwinmm -lWs2_32 -o bin\32\%fn%.dll -Wl,--out-implib,bin\32\%fn%.lib

::设置64位GCC
set path=%tmp%;c:\mingw\x86_64\bin
::设置目标平台(64位)
set GOARCH=amd64
::编译64位静态库
go build -buildmode=c-archive -o bin\64\%fn%.a %gn%
::生成DLL,LIB文件
gcc %dn% bin\64\%fn%.a -shared -lwinmm -lWs2_32 -o bin\64\%fn%.dll -Wl,--out-implib,bin\64\%fn%.lib