function fzfp
    fzf --preview 'bat --style numbers --color always {}' $argv
end
