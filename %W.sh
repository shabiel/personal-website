#!/bin/bash
HOME="/home/sam"
cd "$(dirname "$0")"
source ../fileman.env
mumps -run GTMLNX^VPRJREQ #&2>>ws.log
