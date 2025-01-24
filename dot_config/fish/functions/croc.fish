function croc
    if test (count $argv) -eq 1
        set -x CROC_SECRET $argv[1]
        /usr/bin/croc --pass 's74Yv2DhmAtEEkRKTVFCKkJFfn' --relay '1.12.254.118:9009'
    else
        /usr/bin/croc --pass 's74Yv2DhmAtEEkRKTVFCKkJFfn' --relay '1.12.254.118:9009' $argv
    end
end