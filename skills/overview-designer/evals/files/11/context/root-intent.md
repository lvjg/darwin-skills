# Gateway download authorization local-design intent

Complete only the `Gateway download authorization` key design within the adopted export-download design. An authorized user must receive a five-minute signed download link for a completed export; a denied user must receive a bounded denial result with a stable reason when the owning contract provides one; an unavailable dependency must not be presented as denial or authorization.

The surrounding Export Service -> Download Gateway -> object store route is adopted and outside this task's mutation authority. Design choices inside Download Gateway are delegated. Do not redesign the surrounding system or silently change an external owner's contract. If the requested denial reason cannot be obtained from the active owner contract, expose that condition and the owner decision needed.

Only `design/gateway-download-authorization.md` may be modified. Do not implement code.
