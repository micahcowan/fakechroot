# Additional environment setting for debootstrap

# Add /usr/sbin and /sbin to PATH if chroot command can't be found
if ! command -v chroot >/dev/null; then
    PATH="${PATH:-/usr/bin:/bin}:/usr/sbin:/sbin"
    export PATH
fi

# Set a list of command substitutions needed by debootstrap
fakechroot_debootstrap_env_cmd_subst="
    /bin/mount=/bin/true
    /sbin/devfs=/bin/true
    /sbin/insserv=/bin/true
    /sbin/ldconfig=/bin/true
    /usr/bin/ischroot=/bin/true
    /usr/bin/ldd=@bindir@/ldd.fakechroot
    /usr/bin/mkfifo=/bin/true
    /var/lib/dpkg/info/freebsd-utils.postinst=/bin/true
    /var/lib/dpkg/info/kbdcontrol.postinst=/bin/true
"
FAKECHROOT_CMD_SUBST="${FAKECHROOT_CMD_SUBST:+$FAKECHROOT_CMD_SUBST:}$(echo $fakechroot_debootstrap_env_cmd_subst | tr ' ' ':')"
export FAKECHROOT_CMD_SUBST

# Set the default list of directories excluded from being chrooted
FAKECHROOT_EXCLUDE_PATH="${FAKECHROOT_EXCLUDE_PATH:-/dev:/proc:/sys}"
export FAKECHROOT_EXCLUDE_PATH

# Change path for unix sockets because we don't want to exceed 108 bytes
FAKECHROOT_AF_UNIX_PATH=/tmp
export FAKECHROOT_AF_UNIX_PATH
