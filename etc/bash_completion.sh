# bash completion support for git-extras.

_git_squash_all(){
  __gitcomp "$(__git_heads '' $track)"
}

_git_sqwish(){
  __gitcomp_nl "$(__git_refs '' $track)"
}
