# Function to display Git branch and status information.
git_prompt_info() {
  local branch
  if branch=$(git symbolic-ref --short -q HEAD 2>/dev/null); then
    echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${branch}${ZSH_THEME_GIT_PROMPT_SUFFIX}"
  fi
}

# Function to display Git repository status.
git_prompt_status() {
  # Avoid declaring status as a read-only variable.
  local status
  status=$(git status --porcelain 2>/dev/null)
  if [[ -n $status ]]; then
    local added modified deleted renamed unmerged untracked
    added=$(echo "$status" | grep "^A" | wc -l)
    modified=$(echo "$status" | grep "^M" | wc -l)
    deleted=$(echo "$status" | grep "^D" | wc -l)
    renamed=$(echo "$status" | grep "^R" | wc -l)
    unmerged=$(echo "$status" | grep "^U" | wc -l)
    untracked=$(echo "$status" | grep "^??" | wc -l)
    echo "${ZSH_THEME_GIT_PROMPT_DIRTY}+${added} ${ZSH_THEME_GIT_PROMPT_MODIFIED}~${modified} ${ZSH_THEME_GIT_PROMPT_DELETED}-${deleted} ${ZSH_THEME_GIT_PROMPT_RENAMED}➜${renamed} ${ZSH_THEME_GIT_PROMPT_UNMERGED}═${unmerged} ${ZSH_THEME_GIT_PROMPT_UNTRACKED}✭${untracked}"
  else
    echo "${ZSH_THEME_GIT_PROMPT_CLEAN}"
  fi
}

# Function to display the virtual environment name.
virtualenv_prompt_info() {
  if [[ -n $VIRTUAL_ENV ]]; then
    echo "${ZSH_THEME_VIRTUALENV_PREFIX}$(basename $VIRTUAL_ENV)${ZSH_THEME_VIRTUALENV_SUFFIX}"
  fi
}

PROMPT="%1~%{$reset_color%}\$(git_prompt_info)\$(virtualenv_prompt_info)${FG[153]}\$(git_prompt_status) ${FG[153]}ᐅ%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX=" ${FG[187]}("
ZSH_THEME_GIT_PROMPT_SUFFIX="${FG[187]})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" ${FG[139]}✕"
ZSH_THEME_GIT_PROMPT_CLEAN=" ${FG[079]}✓"

ZSH_THEME_GIT_PROMPT_ADDED="${FG[114]}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="${FG[180]}✹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="${FG[131]}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="${FG[075]}➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="${FG[067]}═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="${FG[138]}✭%{$reset_color%}"

ZSH_THEME_VIRTUALENV_PREFIX=" ["
ZSH_THEME_VIRTUALENV_SUFFIX="]"
