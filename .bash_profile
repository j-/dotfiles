export PROMPT_COMMAND=custom_ps1;

# add symlinks in ~/.path to PATH
mkdir -p ~/.path;
for ITEM in /bin/ls -fbd1 ~/.path/*; do
	[ -d "$ITEM" ] && PATH="$ITEM:$PATH";
done;

[ -f ~/.functions ] && source ~/.functions;
[ -f ~/.bash_aliases ] && source ~/.bash_aliases;

if [ -n "$SSH_TTY" ] || [ "$SHLVL" -gt 1 ]; then
	export EDITOR='nano';
elif platform win32; then
	export EDITOR='sublime_text --wait';
else
	export EDITOR='subl --wait';
fi;

# shell options
shopt -s cdspell checkwinsize dotglob histappend;
set completion-ignore-case on;

# windows doesn't like these options
if ! platform win32; then
	shopt -s dirspell globstar;
fi;

# add ssh keys to agent
{ eval $(ssh-agent); ssh-add ~/.ssh/*.key; } &> /dev/null;

# autocomplete ssh hosts
if [ -e "$HOME/.ssh/config" ]; then
	complete -o default -o nospace -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
fi;

function custom_ps1 {
	# fetch exit code of last command
	local  EXIT="$?";

	# set shell title to current working directory
	set_shell_title $(short_pwd)

	# color codes
	local  RESET="\e[0m";
	local  BLACK="\e[30;1m";
	local    RED="\e[0;31m";
	local  GREEN="\e[0;32m";
	local YELLOW="\e[0;33m";
	local   BLUE="\e[0;34m";
	local PURPLE="\e[0;35m";

	# prompt components
	local  OPEN="$BLACK[$RESET";
	local CLOSE="$BLACK]$RESET";
	local  TIME="$BLUE\@$RESET";
	local    AT="$YELLOW@$RESET";
	local  HOST="$GREEN\h$RESET";
	local   PWD="$PURPLE\w$RESET";

	# dim exit code when 0
	if [ $EXIT == 0 ]; then
		EXIT="$BLACK$EXIT$RESET";
	else
		EXIT="$RESET$EXIT";
	fi;

	# show root in red
	if [ "$(id -u)" == "0" ]; then
		USER="$RED\u$RESET";
	else
		USER="$GREEN\u$RESET";
	fi;

	# construct prompt
	PS1="\n";
	PS1+="$EXIT ";
	PS1+="$OPEN$TIME$CLOSE ";
	PS1+="$OPEN$USER$AT$HOST$CLOSE ";
	PS1+="$OPEN$PWD$CLOSE";

	# show repo branch
	if [ -d "$(test_path_recursive .git)" ]; then
		local GITBRANCH="$(__git_ps1 '%s' 2> /dev/null || git rev-parse --abbrev-ref HEAD 2> /dev/null)";
		if [ "${GITBRANCH}" != "" ]; then
			PS1+=" ${OPEN}${YELLOW}${GITBRANCH}${RESET}${CLOSE}";
		fi;
	elif [ -d "$(test_path_recursive .hg)" ]; then
		local HGBRANCH="$(hg id -b 2> /dev/null)";
		if [ "${HGBRANCH}" != "" ]; then
			PS1+=" ${OPEN}${YELLOW}${HGBRANCH}${RESET}${CLOSE}";
		fi;
	fi;

	# finish with \$ which shows # as root and $ otherwise
	PS1+="\n\$ ";
}
