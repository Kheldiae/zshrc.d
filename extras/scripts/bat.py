#!/usr/bin/env python3
# -*- coding: utf-8 -*-

from os     import execvp
import sys
import subprocess

if __name__ == "__main__":
    try:
        from pixcat import Image

        im = Image(sys.argv[1]).fit_screen(v_margin=-2, h_margin=-1)
        bt = subprocess.Popen(["bat", "--style=header,grid", "--paging=never", "--file-name", sys.argv[1]] + sys.argv[2:], stdin=subprocess.PIPE)
        bt.communicate(b"\n"*im.rows)
        print("\033[A"*(im.rows+2))
        im.show()
        print("")
    except:
        execvp("bat", sys.argv)

# vim: ft=python
