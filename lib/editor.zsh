export EDITOR
export CVSEDITOR

function not_run_from_ssh () {
        ps x|grep "${PPID}.*sshd"|grep -v grep
        echo $?
}

if [[ -x `which gvim` && $(not_run_from_ssh) = 1 ]]; then
        alias vi=gvim
fi

if [[ -x `which mate` && $(not_run_from_ssh) = 1 ]]; then
        EDITOR="mate -w"
        # Useful functions for bundle development
        function reload_textmate(){
        osascript -e 'tell app "TextMate" to reload bundles'
}
function bundle () {
cd "$HOME/Library/Application Support/TextMate/Bundles/$1.tmbundle"
    }
    _bundle() {
            bundle_path="$HOME/Library/Application Support/TextMate/Bundles"
            compadd $(print -l $bundle_path/*.tmbundle(:t:r))
    }
elif [[ -x `which gvim` ]]; then
        EDITOR=gvim
        CVSEDITOR='gvim -f'
elif [[ -x `which vim` ]]; then
        EDITOR=vim
elif [[ -x `which vi` ]]; then
        EDITOR=vi  
elif [[ -x `which nano` ]]; then
        EDITOR=nano
elif [[ -x `which pico` ]]; then
        EDITOR=pico
else
        EDITOR=vi
fi

# Set EDITOR as default for plaintext stuff
for s in txt tex c cc cxx cpp gp m md markdown otl; do
        alias -s $s=$EDITOR
done

# Abuse the "open" command on OS X
if [[ $OSTYPE[1,6] == "darwin" ]]; then
        for s in mp3 wav aac \
                ogg avi mp4 m4v mov qt mpg mpeg \
                jpg jpeg png psd bmp gif tif tiff \
                eps ps pdf html dmg; do
        alias -s $s=open
done
fi

