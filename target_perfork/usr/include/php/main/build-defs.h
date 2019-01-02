/*                                                                -*- C -*-
   +----------------------------------------------------------------------+
   | PHP Version 7                                                        |
   +----------------------------------------------------------------------+
   | Copyright (c) 1997-2017 The PHP Group                                |
   +----------------------------------------------------------------------+
   | This source file is subject to version 3.01 of the PHP license,      |
   | that is bundled with this package in the file LICENSE, and is        |
   | available through the world-wide-web at the following url:           |
   | http://www.php.net/license/3_01.txt                                  |
   | If you did not receive a copy of the PHP license and are unable to   |
   | obtain it through the world-wide-web, please send a note to          |
   | license@php.net so we can mail you a copy immediately.               |
   +----------------------------------------------------------------------+
   | Author: Stig Sæther Bakken <ssb@php.net>                             |
   +----------------------------------------------------------------------+
*/

/* $Id$ */

#define CONFIGURE_COMMAND " './configure'  '--target=arm-buildroot-linux-gnueabihf' '--host=arm-buildroot-linux-gnueabihf' '--build=x86_64-pc-linux-gnu' '--prefix=/usr' '--exec-prefix=/usr' '--sysconfdir=/etc' '--localstatedir=/var' '--program-prefix=' '--disable-gtk-doc' '--disable-gtk-doc-html' '--disable-doc' '--disable-docs' '--disable-documentation' '--with-xmlto=no' '--with-fop=no' '--disable-dependency-tracking' '--enable-ipv6' '--disable-static' '--enable-shared' '--mandir=/usr/share/man' '--infodir=/usr/share/info' '--disable-all' '--without-pear' '--with-config-file-path=/etc' '--disable-phpdbg' '--disable-rpath' '--enable-cli' '--enable-cgi' '--enable-fpm' '--with-apxs2=/home/cmi_at151/aplex/buildroot-2017.02.8/output/host/usr/arm-buildroot-linux-gnueabihf/sysroot/usr/bin/apxs' '--enable-posix' '--enable-session' '--enable-json' '--enable-zip' '--with-openssl=/home/cmi_at151/aplex/buildroot-2017.02.8/output/host/usr/arm-buildroot-linux-gnueabihf/sysroot/usr' '--with-zlib=/home/cmi_at151/aplex/buildroot-2017.02.8/output/host/usr/arm-buildroot-linux-gnueabihf/sysroot/usr' '--with-readline=/home/cmi_at151/aplex/buildroot-2017.02.8/output/host/usr/arm-buildroot-linux-gnueabihf/sysroot/usr' '--with-pcre-regex=/home/cmi_at151/aplex/buildroot-2017.02.8/output/host/usr/arm-buildroot-linux-gnueabihf/sysroot/usr' 'build_alias=x86_64-pc-linux-gnu' 'host_alias=arm-buildroot-linux-gnueabihf' 'target_alias=arm-buildroot-linux-gnueabihf' 'CFLAGS=-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os ' 'LDFLAGS=' 'CPP=/home/cmi_at151/aplex/buildroot-2017.02.8/output/host/usr/bin/arm-linux-gnueabihf-cpp' 'CXXFLAGS=-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os '"
#define PHP_ADA_INCLUDE		""
#define PHP_ADA_LFLAGS		""
#define PHP_ADA_LIBS		""
#define PHP_APACHE_INCLUDE	""
#define PHP_APACHE_TARGET	""
#define PHP_FHTTPD_INCLUDE      ""
#define PHP_FHTTPD_LIB          ""
#define PHP_FHTTPD_TARGET       ""
#define PHP_CFLAGS		"$(CFLAGS_CLEAN) "
#define PHP_DBASE_LIB		""
#define PHP_BUILD_DEBUG		""
#define PHP_GDBM_INCLUDE	""
#define PHP_IBASE_INCLUDE	""
#define PHP_IBASE_LFLAGS	""
#define PHP_IBASE_LIBS		""
#define PHP_IFX_INCLUDE		""
#define PHP_IFX_LFLAGS		""
#define PHP_IFX_LIBS		""
#define PHP_INSTALL_IT		"$(mkinstalldirs) '$(INSTALL_ROOT)/usr/modules' &&                 $(mkinstalldirs) '$(INSTALL_ROOT)/etc/apache2' &&                  /home/cmi_at151/aplex/buildroot-2017.02.8/output/host/usr/arm-buildroot-linux-gnueabihf/sysroot/usr/bin/apxs -S LIBEXECDIR='$(INSTALL_ROOT)/usr/modules'                        -S SYSCONFDIR='$(INSTALL_ROOT)/etc/apache2'                        -S PREFIX='$(INSTALL_ROOT)/usr'                        -i -a -n php7 libphp7.la"
#define PHP_IODBC_INCLUDE	""
#define PHP_IODBC_LFLAGS	""
#define PHP_IODBC_LIBS		""
#define PHP_MSQL_INCLUDE	""
#define PHP_MSQL_LFLAGS		""
#define PHP_MSQL_LIBS		""
#define PHP_MYSQL_INCLUDE	"@MYSQL_INCLUDE@"
#define PHP_MYSQL_LIBS		"@MYSQL_LIBS@"
#define PHP_MYSQL_TYPE		"@MYSQL_MODULE_TYPE@"
#define PHP_ODBC_INCLUDE	""
#define PHP_ODBC_LFLAGS		""
#define PHP_ODBC_LIBS		""
#define PHP_ODBC_TYPE		""
#define PHP_OCI8_SHARED_LIBADD 	""
#define PHP_OCI8_DIR			""
#define PHP_OCI8_ORACLE_VERSION		""
#define PHP_ORACLE_SHARED_LIBADD 	"@ORACLE_SHARED_LIBADD@"
#define PHP_ORACLE_DIR				"@ORACLE_DIR@"
#define PHP_ORACLE_VERSION			"@ORACLE_VERSION@"
#define PHP_PGSQL_INCLUDE	""
#define PHP_PGSQL_LFLAGS	""
#define PHP_PGSQL_LIBS		""
#define PHP_PROG_SENDMAIL	""
#define PHP_SOLID_INCLUDE	""
#define PHP_SOLID_LIBS		""
#define PHP_EMPRESS_INCLUDE	""
#define PHP_EMPRESS_LIBS	""
#define PHP_SYBASE_INCLUDE	""
#define PHP_SYBASE_LFLAGS	""
#define PHP_SYBASE_LIBS		""
#define PHP_DBM_TYPE		""
#define PHP_DBM_LIB		""
#define PHP_LDAP_LFLAGS		""
#define PHP_LDAP_INCLUDE	""
#define PHP_LDAP_LIBS		""
#define PHP_BIRDSTEP_INCLUDE     ""
#define PHP_BIRDSTEP_LIBS        ""
#define PEAR_INSTALLDIR         ""
#define PHP_INCLUDE_PATH	".:"
#define PHP_EXTENSION_DIR       "/usr/lib/php/extensions/no-debug-non-zts-20160303"
#define PHP_PREFIX              "/usr"
#define PHP_BINDIR              "/usr/bin"
#define PHP_SBINDIR             "/usr/sbin"
#define PHP_MANDIR              "/usr/share/man"
#define PHP_LIBDIR              "/usr/lib/php"
#define PHP_DATADIR             "/usr/share/php"
#define PHP_SYSCONFDIR          "/etc"
#define PHP_LOCALSTATEDIR       "/var"
#define PHP_CONFIG_FILE_PATH    "/etc"
#define PHP_CONFIG_FILE_SCAN_DIR    ""
#define PHP_SHLIB_SUFFIX        "so"
