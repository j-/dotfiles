export PROMPT_COMMAND=custom_ps1;

if [ -n "$SSH_TTY" ] || [ "$SHLVL" -gt 1 ]; then
	export EDITOR='nano';
else
	export EDITOR='sublime_text --wait';
fi;

# shell options
shopt -s cdspell checkwinsize dotglob histappend;
set completion-ignore-case on;

# windows doesn't like these options
if [[ "$(uname)" != MINGW* ]]; then
	shopt -s dirspell globstar;
fi;

# add ssh keys to agent
{ eval $(ssh-agent); ssh-add ~/.ssh/*.key; } &> /dev/null;

# add symlinks in ~/.path to PATH
mkdir -p ~/.path;
for ITEM in $(ls -fbd1 ~/.path/*); do
	[ -d $ITEM ] && PATH="$ITEM:$PATH";
done;

# import bash aliases if the file exists
if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases;
fi;

# autocomplete ssh hosts
if [ -e "$HOME/.ssh/config" ]; then
	complete -o default -o nospace -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
fi;

function short_pwd {
	# take $PWD
	# if it starts with $HOME, replace it with ~
	# remove trailing slash
	echo "$PWD/" | sed "s@^$HOME/@~/@" | sed "s/\/\$//";
}

function custom_ps1 {
	# fetch exit code of last command
	local  EXIT="$?";

	# set shell title to current working directory
	echo -ne "\e]2;$(short_pwd)\a";

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

	# show git branch
	if [ -d "$(test_path_recursive .git)" ]; then
		# try and use git ps1
		local GITPS1="$(__git_ps1 '%s' 2> /dev/null)";
		# if we got something back from git ps1
		if [ "$GITPS1" != "" ]; then
			local BRANCH="$GITPS1";
		else
			# fall back to git function
			local BRANCH="$(git rev-parse --abbrev-ref HEAD 2> /dev/null || echo ?)";
		fi
		# branch component
		local GIT="$YELLOW$BRANCH$RESET";
		# add to prompt
		PS1+=" $OPEN$GIT$CLOSE";
	fi;

	# finish with \$ which shows # as root and $ otherwise
	PS1+="\n\$ ";
}
