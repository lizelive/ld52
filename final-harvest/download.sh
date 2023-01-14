dir=${1:-.}
  git clone --separate-git-dir=$(mktemp -u) --depth=1 <my-node-repo> $dir && rm $dir/.git