#!/usr/bin/env bash

SITE_DEPLOY_DIR=$(dirname $0)/../${DEPLOY_DIR_NAME:-'abtool-docs'}
if [ ! -d ${SITE_DEPLOY_DIR} ]
then
    mkdir -p ${SITE_DEPLOY_DIR}
    pushd ${SITE_DEPLOY_DIR}
    git clone -b site git@github.com:larryhou/abtool-gitbook.git .
    popd
fi

rsync -av --exclude='/.git' --delete $(dirname $0)/_book/ ${SITE_DEPLOY_DIR}/
pushd ${SITE_DEPLOY_DIR}
git add . 
git commit -a -m "deploy gitbook $(date '+%Y-%m-%d %H:%M:%S')"
git push
popd
