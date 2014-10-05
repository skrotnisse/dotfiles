<h3>Dotfiles</h3>
Dotfiles for my linux configuration.

<h4>Installation</h4>
Installation of all prerequisites followed by symlink synchronization.
<pre><code>git clone https://github.com/skrotnisse/dotfiles
~/dotfiles/dotfiles.sh install</code></pre>

<h4>Synchronize links</h4>
This will synchronize the dotfiles repo to the symlinks of the home directory.
<pre><code>~/dotfiles/dotfiles.sh refresh</code></pre>

<h4>Delete links</h4>
This will delete all symlinks between the home directory and the actual dotfiles.
<pre><code>~/dotfiles/dotfiles.sh delete</code></pre>

