<h3>Dotfiles</h3>
Dotfiles for my linux configuration with an installation shell-script. The script uses stow to maintain symbolic links.

Inspired by: <a href="https://github.com/klippx/dotfiles">klippx</a>, <a href="https://github.com/fsrc/stowedots">fsrc</a> and <a href="https://www.youtube.com/watch?v=zhdO46oqeRw">gotbletu</a>

<h4>Installation</h4>
Install required packages and perform symlink synchronization:
<pre><code>git clone https://github.com/skrotnisse/dotfiles
cd dotfiles
./dotfiles.sh install</code></pre>

Switch to zsh:
<pre><code>chsh -s /bin/zsh</code></pre>


<h4>Synchronize links</h4>
Synchronize the locally stored dotfiles to the home directory (create/remove symlinks):
<pre><code>cd dotfiles
./dotfiles.sh refresh</code></pre>

<h4>Delete links</h4>
Delete all symlinks between the home directory and the locally stored dotfiles:
<pre><code>cd dotfiles
./dotfiles.sh delete</code></pre>

