########################################
# wxxtlc
# repo http://wxcode.svn.sourceforge.net/viewvc/wxcode/trunk/wxCode/components/treelistctrl/
# dwnl http://sourceforge.net/projects/wxcode/files/Components/treelistctrl/
set(VER 1208)
set(REPO https://github.com/smanders/wxTLC)
set(PRO_WXXTLC
  NAME wxxtlc
  SUPERPRO wxx
  SUBDIR wxTLC
  WEB "wxTLC" http://wxcode.sourceforge.net/components/treelistctrl/ "wxTLC (treelistctrl) on sourceforge"
  LICENSE "open" http://wxcode.sourceforge.net/rules.php "wxCode components must use wxWindows license"
  DESC "a multi column tree control"
  REPO "repo" ${REPO} "wxTLC repo on github"
  VER ${VER}
  GIT_ORIGIN git://github.com/smanders/wxTLC.git
  GIT_TAG sdl_${VER} # TODO: rename tag
  GIT_REF v${VER}
  DLURL http://downloads.sourceforge.net/project/wxcode/Components/treelistctrl/treelistctrl_${VER}.zip
  DLMD5 49252811c837c74b6b627cc36468c2fc
  PATCH ${PATCH_DIR}/wxx.tlc.patch
  DIFF ${REPO}/compare/
  )
########################################
function(mkpatch_wxxtlc)
  xpRepo(${PRO_WXXTLC})
endfunction()
########################################
function(download_wxxtlc)
  xpNewDownload(${PRO_WXXTLC})
endfunction()
########################################
function(patch_wxxtlc)
  patch_wxx()
  xpPatch(${PRO_WXXTLC})
endfunction()
