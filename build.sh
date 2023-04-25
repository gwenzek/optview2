#!/usr/bin/bash
CC=clang CXX=/usr/bin/clang++ CXXFLAGS='-fsave-optimization-record'
set -eu

zig build-obj main.zig -femit-llvm-ir
rm main.o

function count_remarks(){
	echo Missed `grep -F '!Missed' main.opt.yaml | wc -l`
	echo Passed `grep -F '!Passed' main.opt.yaml | wc -l`
}

# /home/guw/github/zig-bootstrap/out/build-llvm-host/bin/llc -O3 --pass-remarks-filter='.*' --pass-remarks-output=remarks.opt.yaml main.ll
# /home/guw/github/zig-bootstrap/out/build-llvm-host/bin/opt  --pass-remarks-filter='.*' --pass-remarks-output=remarks.opt.yaml main.ll -o main.opt.ll  -passes='default<O3>'
/home/guw/github/zig/build/stage3/bin/zig build-obj main.zig -femit-opt-remarks=main.opt.yaml -OReleaseSafe
count_remarks
~/github/optview2/venv/bin/python opt-viewer.py --collect-opt-success --exclude-name='NeverInline|NotPossible' --exclude-text="builtin.default_panic.*not inlined into" --source-dir . .
firefox ./html/main.zig.html
