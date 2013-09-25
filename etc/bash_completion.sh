# bash completion support for git-extras.

_git_sqwish(){
  __gitcomp_nl "$(__git_refs '' $track)"
}
