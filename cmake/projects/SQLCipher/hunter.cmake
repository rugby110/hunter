include(hunter_add_version)
include(hunter_cacheable)
include(hunter_configuration_types)
include(hunter_download)
include(hunter_pick_scheme)

hunter_add_version(
        PACKAGE_NAME
        SQLCipher
        VERSION
        "3.4.0-p1"
        URL
        "file:///tmp/sqlcipher-patched.tar.gz"
        SHA1
        704e0661bc9e77caa0a043a23ccda06283bed1ff 
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
