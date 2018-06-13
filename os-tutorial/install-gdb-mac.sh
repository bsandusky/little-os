mkdir -p /tmp/src
cd /tmp/src
curl -O https://ftp.gnu.org/gnu/gdb/gdb-8.1.tar.gz
tar xf gdb-8.1.tar.gz
mkdir gdb-build
cd gdb-build
export PREFIX="/usr/local/i386elfgcc"
export TARGET=i386-elf
../gdb-8.1/configure --target="$TARGET" --prefix="$PREFIX" --program-prefix=i386-elf-
make
make install
rm -rf /tmp/src