for server in $(nvr --serverlist); do
    nvr --servername "$server" -cc 'set background=light'
done

