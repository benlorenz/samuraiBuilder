using BinaryBuilder

versionstr = "0.6"
version = VersionNumber(versionstr)

sources = [
    "https://github.com/michaelforney/samurai/releases/download/$(versionstr)/samurai-$(versionstr).tar.gz" =>
        "b1ead55ec7b319e08e1c66924c55c2af467f32a250cb86827b7a4496b6a8822f",
]

script = raw"""
cd samurai-0.6
make install PREFIX=${prefix}
ln -s samu ${prefix}/bin/ninja
"""

platforms = [
 Linux(:i686, libc=:glibc)
 Linux(:x86_64, libc=:glibc)
# Linux(:aarch64, libc=:glibc) #struct st_mtim error
 Linux(:armv7l, libc=:glibc, call_abi=:eabihf)
 Linux(:powerpc64le, libc=:glibc)
 Linux(:i686, libc=:musl)
 Linux(:x86_64, libc=:musl)
 Linux(:aarch64, libc=:musl)
 Linux(:armv7l, libc=:musl, call_abi=:eabihf)
 MacOS(:x86_64)
 FreeBSD(:x86_64)
# Windows(:i686) # not supported
# Windows(:x86_64) # not supported
]

products(prefix) = [
    ExecutableProduct(prefix, "ninja", :ninja)
    ExecutableProduct(prefix, "samu", :samu)
]

dependencies = [
]

build_tarballs(ARGS, "samurai", version, sources, script, platforms, products, dependencies)
