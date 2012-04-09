#!/bin/bash
python ./doc/objc_dep.py ./ > ./doc/Tiny4Note_ClassDependancies.dot
open -a Graphviz ./doc/Tiny4Note_ClassDependancies.dot

