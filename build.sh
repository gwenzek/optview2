CC=clang CXX=/usr/bin/clang++ CXXFLAGS='-fsave-optimization-record'
set -eux

zig build-exe main.zig -femit-llvm-ir

/home/guw/github/zig-bootstrap/out/build-llvm-host/bin/llc --pass-remarks-filter='.*' --pass-remarks-output=remarks.opt.yaml main.ll
wc -l remarks.opt.yaml
python $HOME/github/optview2/opt-viewer.py --source-dir . .
	# firefox ./html/index.html
