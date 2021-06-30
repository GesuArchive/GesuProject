#!/usr/bin/env python3
import sys, subprocess

# "dm -l -verbose GesuProject.dme"
result = subprocess.run(['dm', '-l', '-verbose', 'GesuProject.dme'], stdout=subprocess.PIPE)
result.stdout.decode('utf-8')


sys.exit(0)
