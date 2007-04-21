if [ -z "$BUILDROOT" ]; then
    BUILDROOT=`dirname $0`/root
fi

BUILDROOT=`readlink -f $BUILDROOT`

CPPFLAGS="-I$BUILDROOT/include"
LDFLAGS="-L$BUILDROOT/lib -Wl,-rpath,../lib"
PKG_CONFIG_PATH="$BUILDROOT/lib/pkgconfig"
LD_LIBRARY_PATH="$BUILDROOT/lib"
PATH="$BUILDROOT/bin:$PATH"

export CPPFLAGS
export LDFLAGS
export BUILDROOT
export PKG_CONFIG_PATH
export LD_LIBRARY_PATH
export PATH
