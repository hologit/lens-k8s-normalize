pkg_name=lens-k8s-normalize
pkg_origin=holo
pkg_version="1.3"
pkg_maintainer="Chris Alfano <chris@jarv.us>"
pkg_license=("MIT")
pkg_build_deps=(
)
pkg_deps=(
  core/git
  core/node
)
pkg_bin_dirs=(bin)


do_build() {
  pushd "${CACHE_PATH}" > /dev/null

  build_line "Generating lens script"
  mkdir -v "bin"
  cp -v "${PLAN_CONTEXT}/bin"/* "./bin/"
  fix_interpreter "bin/*" core/node bin/node

  build_line "Running: npm install"
  cp -v "${PLAN_CONTEXT}"/package{,-lock}.json ./
  npm ci

  popd > /dev/null
}

do_install() {
  cp -r "${CACHE_PATH}"/* "${pkg_prefix}/"
}

do_strip() {
  return 0
}
