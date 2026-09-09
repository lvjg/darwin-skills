# Current system

- The report generator writes each completed immutable report to the existing object store.
- After a successful object write it records the object key, checksum and completion time in the existing report catalog. Failed generations do not create completed catalog rows.
- The API service already authenticates administrators and reads this catalog for an internal status page.
- The platform object-store library already provides five-minute signed download URLs and defines signing failure and expiry behavior.
- There is one active admin application consumer. No active contract requires public links, cached links or proxying report bytes through the API service.
