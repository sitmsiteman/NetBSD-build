#!/bin/sh

INSTALL_LOG="$HOME/netbsd/buildlog.install"
ERROR_LOG="$HOME/netbsd/buildlog.error"
MACHINE="evbarm"
MACHINE_ARCH="aarch64"
JOBS=$(nproc)
KERN="$HOME/netbsd/GENERIC64-DEBUG-EVBARM"
DATE=$(date)
OBJS="$HOME/netbsd/obj"
TOOLDIR="$HOME/netbsd/obj/tooldir.$(uname -s)-$(uname -r)-$(uname -m)"
NETBSD_SRC="$HOME/netbsd/src"

echo "Build start at $DATE"

echo "$DATE" >>"$INSTALL_LOG"
echo "$DATE" >>"$ERROR_LOG"
echo "=========================================="
echo "Build tools" | tee -a "$INSTALL_LOG" | tee -a "$ERROR_LOG"
time $NETBSD_SRC/build.sh -U -u -O $OBJS -x -X ../xsrc -j $JOBS -a "$MACHINE_ARCH" \
       -m "$MACHINE" \
      tools 1>>"$INSTALL_LOG" 2>>"$ERROR_LOG"

echo "=========================================="
echo "Build kernel" | tee -a "$INSTALL_LOG" | tee -a "$ERROR_LOG"
time $NETBSD_SRC/build.sh -U -u -O $OBJS -x -X ../xsrc -j $JOBS -a "$MACHINE_ARCH" \
        -m "$MACHINE" kernel="$KERN" 1>"$INSTALL_LOG" 2>>"$ERROR_LOG"
echo "=========================================="
# echo "Build userland" | tee -a "$INSTALL_LOG" | tee -a "$ERROR_LOG"
# time $NETBSD_SRC/build.sh -U -u -O $OBJS -x -X ../xsrc -j $JOBS -a "$MACHINE_ARCH" \
#       -m "$MACHINE"  release 1>"$INSTALL_LOG" 2>>"$ERROR_LOG"
# echo "=========================================="
echo "Error Log:"
cat "$ERROR_LOG"
