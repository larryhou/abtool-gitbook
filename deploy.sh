#!/usr/bin/env bash

pushd $(dirname $0)
gitbook pdf

SITE_DEPLOY_DIR=../${DEPLOY_DIR_NAME:-'abtool-docs'}
if [ ! -d ${SITE_DEPLOY_DIR} ]
then
    mkdir -p ${SITE_DEPLOY_DIR}
    pushd ${SITE_DEPLOY_DIR}
    git clone -b site git@github.com:larryhou/abtool-gitbook.git .
    popd # SITE_DEPLOY_DIR
fi

rsync -av --exclude='/.git' --delete book.pdf ${SITE_DEPLOY_DIR}/
rsync -av --exclude='/.git' --delete _book/ ${SITE_DEPLOY_DIR}/
pushd ${SITE_DEPLOY_DIR}
git add . 
git commit -a -m "deploy gitbook $(date '+%Y-%m-%d %H:%M:%S')"
git push
popd # SITE_DEPLOY_DIR

popd # abtool
