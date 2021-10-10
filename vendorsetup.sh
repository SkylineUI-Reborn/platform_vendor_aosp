# Shebang is intentionally missing - do not run as a script

# Override host metadata to make builds more reproducible and avoid leaking info
[ -z "${BUILD_USERNAME}" ] && export BUILD_USERNAME=nobody
[ -z "${BUILD_HOSTNAME}" ] && export BUILD_HOSTNAME=android-build

