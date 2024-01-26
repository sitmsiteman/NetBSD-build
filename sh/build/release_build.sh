#!/bin/sh

INSTALL_LOG="buildlog.install"
ERROR_LOG="buildlog.error"
ARCH="amd64"
JOBS=$(nproc)
KERN="debug"
DATE=$(date)
OBJS="$HOME/netbsd/obj"

echo "Build start at $DATE"

echo "$DATE" >>"$INSTALL_LOG"
echo "$DATE" >>"$ERROR_LOG"
echo "=========================================="
echo "Build tools" | tee -a "$INSTALL_LOG" | tee -a "$ERROR_LOG"
time ./build.sh -U -u -O $OBJS -x -X ../xsrc -j $JOBS -m "$ARCH" tools 1>>"$INSTALL_LOG" 2>>"$ERROR_LOG"
echo "=========================================="
echo "Build kernel" | tee -a "$INSTALL_LOG" | tee -a "$ERROR_LOG"
time ./build.sh -U -u -O $OBJS -x -X ../xsrc -j $JOBS -m "$ARCH" kernel="$KERN" 1>"$INSTALL_LOG" 2>>"$ERROR_LOG"
echo "=========================================="
echo "Build userland" | tee -a "$INSTALL_LOG" | tee -a "$ERROR_LOG"
time ./build.sh -U -u -O $OBJS -x -X ../xsrc -j $JOBS -m "$ARCH" release 1>"$INSTALL_LOG" 2>>"$ERROR_LOG"
echo "=========================================="
echo "Error Log:"
cat "$ERROR_LOG"
