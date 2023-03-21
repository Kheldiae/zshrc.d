#
# Really unnecessary funcs/aliases :P
#

function achievement() {
    notify-send -e "Achievement get!" "$*" -i preferences-desktop-gaming
}

function ending() {
    notify-send -e "Ending Unlocked" "$*" -i dictionary-symbolic -u critical
}

function thesola10() { echo "Yes, that's you."; }
function azertyuiop() { echo "You're reaaaaally bored, aren't you?"; }

function youtube-words() {
    sed -e "s|-|+|g" -e "s|_|/|g" <<< "$1=" | base64 -d | xxd -ps | pgp-words
}                           # Print pgp-words for a YouTube video ID

function ':qa!'() {
    echo "Shutting down the computer in 10s..."
    sleep 10
    shutdown now
}                           # Yeah, stop that.
