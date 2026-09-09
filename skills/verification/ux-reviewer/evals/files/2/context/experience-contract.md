# Experience contract

An organization administrator can send a password-reset link for a selected user from the user details page.

At the decisive confirmation checkpoint, the administrator must be able to tell:

- which account will receive the link;
- that the action sends a link rather than immediately changing the password;
- how long the link remains valid;
- which action sends the link and how to cancel safely.

After sending, the interface must identify the recipient and make the immediate resend state clear. This review is limited to the recorded visible and keyboard path; email delivery and backend mutation are separate acceptance boundaries.
