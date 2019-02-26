using BinaryBuilder

versionstr = "0.5"
version = VersionNumber(versionstr)

sources = [
    "https://github.com/michaelforney/samurai/releases/download/$(versionstr)/samurai-$(versionstr).tar.gz" =>
        "a00ef21662719c5e4a18481c8e1b572309ddf47e7087bd5db5664f47352cbb40",
]

script = raw"""
cd samurai-0.5
make install PREFIX=${prefix}
ln -s samu ${prefix}/bin/ninja
"""

platforms = [
 Linux(:i686, libc=:glibc)
 Linux(:x86_64, libc=:glibc)
# Linux(:aarch64, libc=:glibc) # mtim error
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
