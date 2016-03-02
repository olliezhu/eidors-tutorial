netgen-5.3.1
https://sourceforge.net/projects/netgen-mesher/files/netgen-mesher/5.3/

install g++
install tcl8.5 tcl8.5-dev tk8.5 tk8.5-dev
./configure --with-tclconfig=/usr/lib/tcl8.5/ --with-tkconfig=/usr/lib/tk8.5/

install libgl1-mesa-dev libglu1-mesa-dev libtogl1 libtogl-dev libxmu-dev
make

make install
