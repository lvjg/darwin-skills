# Proposal version 2 — authoritative candidate

This revision supersedes version 1.

- The notification service assigns the immutable subscription identifier.
- It persists the subscription through the maintained store's atomic uniqueness constraint before returning success.
- The API passes through the server identifier and preserves authentication, validation, conflict and persistence failures.
- Creation adds no second state owner, compatibility path or background lifecycle.
