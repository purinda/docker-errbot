#!/bin/bash

readonly ERRBIN="/app/venv/bin/errbot"
readonly ERRRUN="/srv"
readonly ERRUSER="err"

for i in data plugins errbackends; do
  [[ ! -d "${ERRRUN}/${i}" ]] && mkdir "${ERRRUN}/${i}"
done

[[ -z ${ERRCONF} ]] && [[ ! -e "${ERRRUN}/config.py" ]] && cp /app/config.py ${ERRRUN}

# sleep if we need to wait for another container
if [[ -n ${WAIT} ]]; then
    echo "Sleep ${WAIT} seconds before starting err..."
    sleep ${WAIT}
fi

echo "source /app/venv/bin/activate" > /srv/.bash_profile
source /app/venv/bin/activate

(for i in $(printenv | grep -v root | grep -v -E '\s+');
do
  key=$(echo $i | sed 's/=.*//g');
  val=$(echo $i | sed 's/.*=\(.*\)/\1/g');
  echo "export $key='$val'";
done) >> /srv/.bash_profile

# change directory
cd "$ERRRUN"

# copy default container image config file if not exist on volume but is specified
${ERRBIN}
