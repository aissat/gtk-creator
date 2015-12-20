#!/bin/bash
#Project compiling script

#Files to compile
FILES="
	*.vala
";

#Compiler command
COMPILER="valac"

#Packages/Libraries
PKG="
	--pkg gtk+-3.0
	--pkg gdk-3.0
	--pkg vte-2.90
	--pkg webkit2gtk-4.0
	--pkg gio-2.0
	--pkg posix
	--pkg gtksourceview-3.0
"

#Other args
OARGS="
	--target-glib=2.36
	-o exec
	-g
"

#Script body
echo Will be compiled: $FILES;
echo Compiler command: $COMPILER
echo Other arguments: $OARGS
echo Packages: $PKG;
echo Command: $COMPILER $FILES $PKG $OARGS;
echo Starting compiler;
$COMPILER $FILES $PKG $OARGS;
echo Exiting;
