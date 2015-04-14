# add symlinks in ~/.path to PATH
mkdir -p ~/.path;
for ITEM in /bin/ls -fbd1 ~/.path/*; do
	[ -d "$ITEM" ] && PATH="$ITEM:$PATH";
done;

[ -f ~/.functions    ] && source ~/.functions;
[ -f ~/.bash_aliases ] && source ~/.bash_aliases;
[ -f ~/.bash_prompt  ] && source ~/.bash_prompt;

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
