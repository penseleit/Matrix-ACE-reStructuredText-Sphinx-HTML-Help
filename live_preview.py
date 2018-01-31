#!/usr/bin/env python
from livereload import Server, shell

# Enter the fully qualified path to the make.bat file with parameters on Windows
buildscript =  'E:/src/Matrix-ACE-reStructuredText-Sphinx-HTML-Help/make.bat html'

# Use the line below for Linux and comment out the windows line above
# buildscript = 'make html'

#load server
server = Server()
server.watch('*.rst', shell(buildscript, cwd='.'))
server.serve(root='_build\html')
