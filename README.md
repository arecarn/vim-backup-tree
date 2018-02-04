# Backup Tree

Provides timestamped backups in a configurable parallel directory tree

## Usage
Enable vim's built in backup feature bad Backup Tree will take care of the rest

```
set backup

" OPTIONAL (defaults to ~/.vim_backup)
set g:backup_tree = '~/.vim_backup_tree"
```

* `:BackupTree`
    * Opens the directory g:backup_tree in a vertical split
* `:BackupTreeCurrent`
    * Opens the directory in g:backup_tree that corresponds to your current
      buffers directory
