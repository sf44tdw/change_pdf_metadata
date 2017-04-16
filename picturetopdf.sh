#!/bin/bash

#指定ディレクトリ内のディレクトリ名に含まれるスペースをアンダースコアに変える。
#指定ントディレクトリ内のディレクトリ内にある画像を全て1つのpdfにまとめる。

# 第一引数でディレクトリパスを指定
DIRPATH=$1
cd ${DIRPATH}

#ファイル、ディレクトリのスペースをアンダースコアに変換
for A in $(ls | grep " " | sed -e s/" "/_/g) ; do mv "$(echo $A | sed -e s/_/' '/g)" $A ; done

THIS_DIR=`pwd`

TEMPDIR="/var/tmp/pdf_t"
rm -rf ${TEMPDIR}
mkdir ${TEMPDIR}

TEMPFILE_1="${TEMPDIR}/repolist1.tmp"

find . -maxdepth 1 -type d -printf '%f\n' > ${TEMPFILE_1}

sed -i "/^\.$/d" ${TEMPFILE_1}

cat ${TEMPFILE_1}

cat ${TEMPFILE_1} | while read TARGET
do

     cd "${TARGET}"
      
     echo ${TARGET}      

     pwd


     COMMAND="convert"

     FILES=`ls -v *.{jpg,png}`

     DEST="${TARGET}.pdf"
     
     EXEC="${COMMAND} ${FILES} ${DEST}"

     echo ${EXEC}

     `${EXEC}`
 
     cd ${THIS_DIR}

     pwd

done

rm -rf ${TEMPDIR}
