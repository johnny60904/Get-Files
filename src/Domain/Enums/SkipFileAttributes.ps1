[Flags()]
enum SkipFileAttributes {
    None = 0
    ReadOnly = 1 # The file is read-only.
    Hidden = 2 # The file is hidden.
    System = 4 # The file is a system file.
    Directory = 16 # The path points to a directory.
    Archive = 32 # The file is marked for archiving (e.g., backup software).
    Device = 64 # Reserved for future use.
    Normal = 128 # A standard file with no special attributes. Valid only when used alone.
    Temporary = 256 # A temporary file.
    SparseFile = 512 # A sparse file.
    ReparsePoint = 1024 # The file or directory has an associated reparse point (e.g., a symbolic link).
    Compressed = 2048 # The file or directory is compressed.
    Offline = 4096 # The data of the file is not available immediately.
    NotContentIndexed = 8192 # The file or directory is not indexed by the content indexing service.
    Encrypted = 16384 # The file or directory is encrypted.
    IntegrityStream = 32768 # The file or directory includes data integrity support.
    NoScrubData = 131072 # The file or directory is excluded from data integrity scans.
    # Default => 6 # Hidden, System
    # All => 196599
}