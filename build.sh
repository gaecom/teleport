#!/bin/bash

#---------------------------------------------------------------
# README
#
# pleas copy build.sh.in to build.sh and change the following
# two lines to fit your env.
#
# Recommend to download miniconda from
#   https://conda.io/miniconda.html
# and install it, root priviledge is not necessary.
#---------------------------------------------------------------
PATH_PYTHON_LINUX=/home/apex/miniconda3
PATH_PYTHON_MACOS=/path/of/your/python/installation

################################################################
# DO NOT TOUCH FOLLOWING CODE
################################################################

PATH_ROOT=$(cd "$(dirname "$0")"; pwd)

function on_error()
{
	echo -e "\033[01m\033[31m"
	echo "==================[ !! ERROR !! ]=================="
	echo ""
	echo -e $1
	echo ""
	echo "==================================================="
	echo -e "\033[0m"
	exit 1
}

function check_python
{
	if [ ! -f "${PYSTATIC}" ]; then
    	on_error "python not found."
	fi
}

function build_linux
{
    PATH_PYTHON=${PATH_PYTHON_LINUX}
	PYEXEC=${PATH_PYTHON}/bin/python3.7
	PYSTATIC=${PATH_PYTHON}/lib/libpython3.7m.a

    check_python

	${PYEXEC} -B "${PATH_ROOT}/build/build.py" $@
}

function build_macos
{
    PATH_PYTHON=${PATH_PYTHON_LINUX}
	PYEXEC=${PATH_PYTHON}/bin/python3.7
	PYSTATIC=${PATH_PYTHON}/lib/libpython3.7m.a

    check_python

	${PYEXEC} -B "${PATH_ROOT}/build/build.py" $@
}

SYSTEM=`uname -s`
if [ $SYSTEM = "Linux" ] ; then
	build_linux
elif [ $SYSTEM = "Darwin" ] ; then   
	build_macos
else 
	echo "Unsupported platform."
fi

