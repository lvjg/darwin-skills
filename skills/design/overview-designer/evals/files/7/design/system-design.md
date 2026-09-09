# Notification Preference Design

## Initial direction

Keep all three services writable and run reconciliation every ten seconds. Add retry state so conflicts eventually converge while every service continues to treat its local copy as current.
