########################################
# curl
xpProOption(curl)
set(VER 7.42.1)
string(REPLACE "." "_" VER_ ${VER})
set(REPO https://github.com/smanders/curl)
set(PRO_CURL
  NAME cURL
  WEB "cURL" http://curl.haxx.se/libcurl/ "libcurl website"
  LICENSE "open" http://curl.haxx.se/docs/copyright.html "curl license: MIT/X derivate license"
  DESC "the multiprotocol file transfer library"
  REPO "repo" ${REPO} "forked curl repo on github"
  VER ${VER}
  GIT_ORIGIN git://github.com/smanders/curl.git
  GIT_UPSTREAM git://github.com/bagder/curl.git
  GIT_TAG xp-${VER_} # what to 'git checkout'
  GIT_REF curl-${VER_} # create patch from this tag to 'git checkout'
  DLURL http://curl.haxx.se/download/curl-${VER}.tar.bz2
  DLMD5 296945012ce647b94083ed427c1877a8
  PATCH ${PATCH_DIR}/curl.patch
  DIFF ${REPO}/compare/bagder:
  )
########################################
function(mkpatch_curl)
  xpRepo(${PRO_CURL})
endfunction()
########################################
function(download_curl)
  xpNewDownload(${PRO_CURL})
endfunction()
########################################
function(patch_curl)
  xpPatch(${PRO_CURL})
endfunction()
########################################
function(build_curl)
  if(NOT (XP_DEFAULT OR XP_PRO_CURL))
    return()
  endif()
  if(NOT (XP_DEFAULT OR XP_PRO_LIBSSH2))
    message(FATAL_ERROR "curl.cmake: requires libssh2")
    return()
  endif()
  if(NOT (XP_DEFAULT OR XP_PRO_CARES))
    message(FATAL_ERROR "curl.cmake: requires cares")
    return()
  endif()
  if(NOT DEFINED libssh2Tgts)
    build_libssh2(libssh2Tgts)
    set(depTgts ${libssh2Tgts})
  endif()
  if(NOT DEFINED caresTgts)
    build_cares(caresTgts)
    list(APPEND depTgts ${caresTgts})
  endif()
  if(XP_DEFAULT OR XP_PRO_CMAKEXP)
    build_cmakexp(cmTgts)
    list(APPEND depTgts ${cmTgts})
  endif()
  set(XP_CONFIGURE
    -DBUILD_CURL_EXE=ON
    -DBUILD_CURL_TESTS=OFF
    -DCURL_STATICLIB=ON
    -DENABLE_ARES=ON
    -DFIND_ARES_MODULE_PATH=ON
    -DCURL_ZLIB_MODULE_PATH=ON
    -DCMAKE_USE_OPENSSL_MODULE_PATH=ON
    -DCMAKE_USE_LIBSSH2_MODULE_PATH=ON
    -DCURL_DISABLE_LDAP=ON
    -DENABLE_LIBIDN=OFF
    )
  configure_file(${PRO_DIR}/use/usexp-curl-config.cmake ${STAGE_DIR}/share/cmake/
    @ONLY NEWLINE_STYLE LF
    )
  xpCmakeBuild(curl "${depTgts}" "${XP_CONFIGURE}")
endfunction()
