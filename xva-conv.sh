#!/bin/bash
#
# (c) 2017 GUEST.it s.r.l. - Alessandro Corbelli
# License: GPL
#
# Sample usage:
# wget --http-user=x --http-password=y http://your.xen.server.host/export?uuid=<VM_UUID> -O - | tar --to-command=./xva-conv.sh -xf -
#

TMP_LASTNAME_PREFIX="/tmp/lastname"

if [ "${TAR_FILETYPE}" != "f" ]; then
   exit
fi

if [[ "${TAR_FILENAME}" =~ "checksum" || "${TAR_FILENAME}" == "ova.xml" ]]; then
   exit
fi

DISKNAME=${TAR_FILENAME%/*}
FILENAME=${TAR_FILENAME#*/}
CURNUMBER=${FILENAME#"${FILENAME%%[!0]*}"}

# First file ? TMP_LASTNAME should be empty
if [ ! -f "${TMP_LASTNAME_PREFIX}_${DISKNAME}" ]; then
   echo ${CURNUMBER} > ${TMP_LASTNAME_PREFIX}_${DISKNAME}

   cat > ${DISKNAME}.raw 
else
   LASTNUM=$(cat ${TMP_LASTNAME_PREFIX}_${DISKNAME});

   # is sequential ?
   if [ $(expr ${LASTNUM} + 1) -eq "${FILENAME}" ]; then
      cat >> ${DISKNAME}.raw
   else
	  for i in $(seq $(expr ${LASTNUM} + 1) $(expr ${FILENAME} - 1)); do
         dd if=/dev/zero of=${DISKNAME}.raw bs=1M count=1 oflag=append conv=notrunc 2>/dev/null
      done

      cat >> ${DISKNAME}.raw
   fi

   echo ${CURNUMBER} > ${TMP_LASTNAME_PREFIX}_${DISKNAME}
fi
