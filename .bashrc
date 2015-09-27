# load the bash's dotfiles.
for file in ~/.{bash_prompt,bash_aliases,bash_functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

