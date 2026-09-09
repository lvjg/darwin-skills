# Review contract

Review `initial/` against the obligations below, then review `current/` as its revision. Both are complete supplied candidates for local commit; stay read-only. `revision.diff` is the complete change between them.

Every supported archive entry must reject a payload of 8 bytes or more before calling the supplied writer. Smaller payloads must produce the writer's receipt unchanged. Rejection is `ValueError("archive too large")` and must produce no write.

`upload` is the normal entry. `restore` is a required maintenance entry selected by `MAINTENANCE_MODE`; it is shipped and supported even when the default mode disables it. The maintenance mode is allowed to become the default for an authorized restoration run. Both entries have the same size obligation. The writer does not check sizes.

`receipt.py` is the unchanged receipt producer used by both revisions. Its consumer and contract are unchanged. An earlier focused execution established `make_receipt("a7") == "archive:a7"`; the source is supplied so the scope and continued relevance of that evidence can be checked. No claim about size checks follows from this evidence.

The author reports that the revision corrects the normal exact-limit defect and has passing normal-entry tests. Evaluate the full candidate and revision rather than treating that report as acceptance of any other route. Deployment and E2E are outside this decision.
