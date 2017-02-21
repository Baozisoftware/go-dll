@echo off

rd bin /s /q
mkdir bin\32
mkdir bin\64

set fn=test
set gn=test.go
set dn=test.def

set tmp=%path%
::ʹ��ƽ̨����ʹ��CGO
set CGO_ENABLED=1

::����32λGCC
set path=%tmp%;c:\mingw\i686\bin
::����Ŀ��ƽ̨(32λ)
set GOARCH=386
::����32λ��̬��
go build -buildmode=c-archive -o bin\32\%fn%.a %gn%
::����DLL,LIB�ļ�
gcc %dn% bin\32\%fn%.a -shared -lwinmm -lWs2_32 -o bin\32\%fn%.dll -Wl,--out-implib,bin\32\%fn%.lib

::����64λGCC
set path=%tmp%;c:\mingw\x86_64\bin
::����Ŀ��ƽ̨(64λ)
set GOARCH=amd64
::����64λ��̬��
go build -buildmode=c-archive -o bin\64\%fn%.a %gn%
::����DLL,LIB�ļ�
gcc %dn% bin\64\%fn%.a -shared -lwinmm -lWs2_32 -o bin\64\%fn%.dll -Wl,--out-implib,bin\64\%fn%.lib