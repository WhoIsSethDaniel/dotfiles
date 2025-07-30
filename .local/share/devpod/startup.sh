#!/bin/bash

echo "RUNNING devpod state sync"
scp "$HOME"/.inputrc mmwebsite:.
scp "$HOME"/.psqlrc mmwebsite:.
scp "$HOME"/.ripgreprc mmwebsite:.
