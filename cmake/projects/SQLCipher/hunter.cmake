include(hunter_add_version)
include(hunter_cacheable)
include(hunter_configuration_types)
include(hunter_download)
include(hunter_pick_scheme)

hunter_add_version(
        PACKAGE_NAME
        SQLCipher
        VERSION
        "3.4.0"
        URL
        "https://github.com/sqlcipher/sqlcipher/archive/v3.4.0.tar.gz"
        SHA1
        9380db7bd1d304b9db59c5d9c26c449ee57bfe01
)

hunter_configuration_types(SQLCipher CONFIGURATION_TYPES Release)
hunter_pick_scheme(DEFAULT url_sha1_sqlcipher)
hunter_cacheable(SQLCipher)
hunter_download(
        PACKAGE_NAME SQLCipher
        PACKAGE_INTERNAL_DEPS_ID "2"
        PACKAGE_UNRELOCATABLE_TEXT_FILES
        "lib/libsqlcipher.la"
)
