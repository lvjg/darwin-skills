LIMIT = 8


def upload(payload, writer):
    if len(payload) > LIMIT:
        raise ValueError("archive too large")
    return writer(payload)


def restore(payload, writer):
    return writer(payload)
