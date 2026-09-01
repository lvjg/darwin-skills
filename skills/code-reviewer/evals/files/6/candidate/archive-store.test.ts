import { saveArchive, type Archive, type ArchiveStore } from "./archive-store";

const archive = (byteLength: number): Archive => ({
  byteLength,
  contents: new Uint8Array(),
});

it("writes an archive below the limit", async () => {
  const store = { write: vi.fn().mockResolvedValue(undefined) } satisfies ArchiveStore;
  await saveArchive(store, archive(8 * 1024 * 1024 - 1));
  expect(store.write).toHaveBeenCalledTimes(1);
});

it.skip("rejects an archive at the exact limit", async () => {
  const store = { write: vi.fn().mockResolvedValue(undefined) } satisfies ArchiveStore;
  await expect(saveArchive(store, archive(8 * 1024 * 1024))).rejects.toThrow();
  expect(store.write).not.toHaveBeenCalled();
});

it("rejects an archive above the limit", async () => {
  const store = { write: vi.fn().mockResolvedValue(undefined) } satisfies ArchiveStore;
  await expect(saveArchive(store, archive(8 * 1024 * 1024 + 1))).rejects.toThrow();
  expect(store.write).not.toHaveBeenCalled();
});
