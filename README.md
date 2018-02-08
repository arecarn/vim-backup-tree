# Backup Tree

Cross platform Vim plugin that provides timestamped backups in a parallel
directory tree.

For example if you save the file /home/user/.vimrc it will be backed up in
/home/user/.vim_backup/home/user/.vimrc_2018-02-08-10 with the timestamp format
being YYYY-MM-DD-HH.

## Usage
Enable Vim's built in backup feature and Backup Tree will take care of the rest.

```
set backup

" Optionally set the location of your backup tree (defaults to ~/.vim_backup)
set g:backup_tree = '~/.vim_backup_tree"
```

* `:BackupTree`
    * Opens the directory g:backup_tree in a vertical split
* `:BackupTreeCurrent`
    * Opens the directory in g:backup_tree that corresponds to your current
      buffers directory
