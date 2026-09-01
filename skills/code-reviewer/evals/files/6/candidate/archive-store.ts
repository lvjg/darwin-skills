export interface Archive {
  byteLength: number;
  contents: Uint8Array;
}

export interface ArchiveStore {
  write(archive: Archive): Promise<void>;
}

const MAX_ARCHIVE_BYTES = 8 * 1024 * 1024;

export async function saveArchive(
  store: ArchiveStore,
  archive: Archive,
): Promise<void> {
  if (archive.byteLength > MAX_ARCHIVE_BYTES) {
    throw new Error("archive is too large");
  }

  await store.write(archive);
}
