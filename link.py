#!/usr/bin/env python

import sys
if sys.version_info[0] < 3:
    sys.exit("python 3 required")

import platform
system = platform.system()
OS_map = {"Darwin": "macos", "Linux": "linux"}
OS = OS_map.get(system, "unknown")

if OS == "unknown":
    sys.exit(f"Unknown OS: {system}")


import json


dotfiles_dir = os.path.realpath(__file__)

with open()