#!/bin/bash -x
sudo yum groupinstall 'Development Tools'
sudo yum install wget
sudo yum install libXext-devel


cd /home/ec2-user/
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/gmp-4.3.2.tar.bz2
tar jxvf gmp-4.3.2.tar.bz2
cd gmp-4.3.2
./configure --disable-shared --enable-static --prefix=/tmp/gcc
make && make install

cd /home/ec2-user/
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpfr-2.4.2.tar.bz2
tar jxvf mpfr-2.4.2.tar.bz2
cd mpfr-2.4.2
./configure --disable-shared --enable-static --prefix=/tmp/gcc --with-gmp=/tmp/gcc
make && make install

cd /home/ec2-user/
wget ftp://gcc.gnu.org/pub/gcc/infrastructure/mpc-0.8.1.tar.gz
tar zxvf mpc-0.8.1.tar.gz
cd mpc-0.8.1
./configure --disable-shared --enable-static --prefix=/tmp/gcc --with-gmp=/tmp/gcc --with-mpfr=/tmp/gcc
make && make install

cd /home/ec2-user/
wget http://www.mr511.de/software/libelf-0.8.13.tar.gz
tar zxvf libelf-0.8.13.tar.gz
cd libelf-0.8.13
./configure --disable-shared --enable-static --prefix=/tmp/gcc
make && make install


##=============================
## QT 4.8.6
##=============================
cd /home/ec2-user
VERS="4.8.6"
SRCDIR="${HOME}/src"
mkdir $SRCDIR
cd $SRCDIR
SRC="https://download.qt.io/archive/qt/4.8/4.8.6"
wget -N $SRC/qt-everywhere-opensource-src-$VERS.tar.gz
tar -xzvf qt-everywhere-opensource-src-$VERS.tar.gz
cd qt-everywhere-opensource-src-$VERS
INSTDIR="/usr/local"
PLATFORM="linux-g++-64"
echo "yes" | ./configure -release -opensource -static -qt-zlib -no-gif -qt-libpng -qt-libmng -qt-libtiff -qt-libjpeg -nomake examples -nomake demos -nomake docs -nomake translations -prefix /usr/local/qt_4.8.6 -platform linux-g++-64
make
sudo make install
export QTDIR="$INSTDIR/qt_$VERS"
export QMAKESPEC="$PLATFORM"


##=============================
## GCC-4.3.4
## -need an older version of gcc so that we can compile Bernese
##=============================

wget -O /home/ec2-user/gcc-4.3.4/libjava/prisms.cc "https://gcc.gnu.org/viewcvs/gcc/branches/ARM/embedded-4_6-branch/libjava/prims.cc?revision=189421&view=co&pathrev=189421"

cd /home/ec2-user
wget https://ftp.gnu.org/gnu/gcc/gcc-4.3.4/gcc-4.3.4.tar.gz
sudo -u ec2-user tar zxvf gcc-4.3.4.tar.gz
sudo -u ec2-user mkdir gobj
cd gobj
sudo -u ec2-user /home/ec2-user/gobj/../gcc-4.3.4/configure --prefix /usr/local/gcc/4.3.4 --with-mpc=/tmp/gcc --with-gmp=/tmp/gcc --with-mpfr=/tmp/gcc --disable-multilib
sudo mkdir -p /usr/local/gcc/4.3.4
make
make install

