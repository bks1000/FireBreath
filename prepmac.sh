#!/bin/bash

GEN='Xcode'

source ${0%/*}/common.sh "$@"

ARCH=-DCMAKE_OSX_ARCHITECTURES="i386;x86_64"

pushd "$BUILDDIR"
cmake -G "$GEN" -DPROJECTS_DIR="${PROJDIR}" ${ARCH} "$@" "${FB_ROOT}"
popd

if [ -f "cmake/patch_xcode.py" ]; then
    while read target proj
    do
        python cmake/patch_xcode.py -f "$proj" -t "$target"
    done < $BUILDDIR/xcode_patch_desc.txt
fi
