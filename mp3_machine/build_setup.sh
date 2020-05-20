#!/bin/bash
if [[ $# -eq 0 ]]; then
	cat << __EOF__
Usage: bash build_script.sh --br-dir <BR dir> [--build-tree-dir <tree dir>] [--br-local]
This Script Builds the MP3 Image for assignemt 4 it requires the location of
buildroot directory and uses the current directory if --build-tree-dir is not specified
--br-dir 		Your Buildroot directory 
--build-tree-dir 	specify your out of tree build directory otherwise it will use 
			the current directory you can ignore it if using --br-local
--br-local 		Disable out of tree build
__EOF__
exit 0
fi
args="$@"
n=2
OUT_OF_TREE=true
while :; do 
	case $1 in
		--br-dir) BUILDROOT_DIR=$2
			if [[ ! -d $BUILDROOT_DIR ]]; then
				echo "Error: No such directory for buildroot"
				exit 1
			fi
			n=2
			;;
		--build-tree-dir) BUILDTREE_DIR=$2
			if [[! -d $BUILDTREE_DIR ]]; then
				echo "Error: No such directory for the build tree"
				exit 1
			fi
			n=2
			;;
		--br-local)
			OUT_OF_TREE=false
			n=1
			;;
		*)
			break
			;;
	esac
	shift $n
done

if [[ $BUILDROOT_DIR == "" ]]; then
	echo "Error : Buildroot directory not specified"
	exit 1
fi

if [[ $BUILDTREE_DIR == "" ]]; then
	BUILDTREE_DIR=$(pwd)
fi

mkdir -p $BUILDTREE_DIR/output && \
cp -r  board/* $BUILDROOT_DIR/board && \
cp -r configs/* $BUILDROOT_DIR/configs

if [[ $? -ne 0 ]]; then
	exit 1
fi

if $OUT_OF_TREE ; then
	make -C $BUILDROOT_DIR O=$BUILDTREE_DIR/output qemu_arm_versatile_mp3_machine_defconfig 
else	
	make qemu_arm_versatile_mp3_machine_defconfig 
fi
echo "All set up now you can move into your build tree and type make. Good Luck :)"
exit 0
