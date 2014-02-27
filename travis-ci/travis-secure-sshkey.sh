#!/bin/bash
# based on https://gist.github.com/floydpink/4631240
ENCRYPTION_FILTER="bundle exec travis encrypt \"\$FILE='\`cat $FILE\`'\" --add"
ID_RSA_TMP=$(mktemp id_rsa.XXXX)

die() {
  echo $@ >&2
  exit 1
}

mysplit() {
  local _umask=$(umask)
  umask 077
  if which gsplit > /dev/null; then
    gsplit "$@"
  else
    split "$@"
  fi
  umask ${_umask}
}

mybase64enc() {
  base64 --break=0
}

mydecrypt() {
  local _umask=$(umask)
  echo -n $id_rsa_p_{00..30} >> "${ID_RSA_TMP}"
  base64 --decode --ignore-garbage "${ID_RSA_TMP}" > /tmp/id_rsa.decoded
  umask ${_umask}
  rm -f "${ID_RSA_TMP}"
}

case $1 in
  decrypt)
    mydecrypt
    cat <<EOF >> ~/.ssh/config
Host github.com
  StrictHostKeyChecking no
  IdentityFile /tmp/id_rsa.decoded
EOF
    ;;
  encrypt)
    mybase64enc > "${ID_RSA_TMP}" || die "failed to decode base64"
    set -x
    mysplit --bytes=100 --numeric-suffixes --suffix-length=2 --filter="${ENCRYPTION_FILTER}" "${ID_RSA_TMP}" id_rsa_p_
    rm -f "${ID_RSA_TMP}"
    ;;
  *)
    echo "Usage: $0 [decrypt|encrypt]" >&2
    exit 1
    ;;
esac
