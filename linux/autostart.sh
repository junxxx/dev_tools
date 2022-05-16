#!/bin/bash
#This is the tool to autostart my custom script
HOME="/home/centos"
SCRIPTPATH=${HOME}"/scripts"
APPPATH=${HOME}"/app"

./${SCRIPTPATH}/gosh.sh
./${SCRIPTPATH}/readnews.sh
nohup ${APPPATH}/book.creator.server/book.creator.server &
nohup ${APPPATH}/dockerhub-hook-handler/dockerhub-webhook &