# EIDORS tutorials

A walk-through of [EIDORS tutorials](http://eidors3d.sourceforge.net/tutorial/tutorial.shtml). Some examples will be straight up copied from the EIDORS page.

## Running EIDORS 3.8 with Netgen 5.3 on Linux

Background: I'm running Ubuntu 14.04 with MATLAB R2015b. YMMV.

Get [eidors-v3.8-ng](http://eidors3d.sourceforge.net/download.shtml) and [netgen-5.3.1](https://sourceforge.net/projects/netgen-mesher/files/netgen-mesher/5.3/).

Unpack netgen and go to your netgen directory. Configure requires a C++ compiler (g++ 4.8.4 works for me) and libtogl requires an older version of Tcl/Tk:
```
apt-get install g++
apt-get install tcl8.5 tcl8.5-dev tk8.5 tk8.5-dev
./configure --with-tclconfig=/usr/lib/tcl8.5/ --with-tkconfig=/usr/lib/tk8.5/
```

Make process will require OpenGL development files + libxmu:
```
install libgl1-mesa-dev libglu1-mesa-dev libtogl-dev libxmu-dev
make
make install
```

Run matlab with `NETGENDIR=/opt/netgen/bin PATH=/opt/netgen/bin:$PATH matlab &` or just `eidors.sh &`
