from archive import restore, upload

MAINTENANCE_MODE = False


def accept_archive(payload, writer):
    handler = restore if MAINTENANCE_MODE else upload
    return handler(payload, writer)
